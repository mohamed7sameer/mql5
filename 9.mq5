//+------------------------------------------------------------------+
//|                                                       testuu.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include <Trade/Trade.mqh>
CTrade trade ;

int e_point = 500;
double e_startVolume = 0.01;
double e_increasePoint = .1;
double e_increaseVolume = 2;



string e_default_symbol_sell = "EURUSD";
string e_default_symbol_buy = "EURUSD";


string e_symbol_sell =  e_default_symbol_sell; //EURUSD
int e_point_b_sell = e_point; // 500
double e_volume_sell=e_startVolume; // 0.01
double e_volume_sell_real = e_volume_sell;
//bool e_found_sell = false;

string e_symbol_buy = e_default_symbol_buy ;  //EURUSD
int e_point_b_buy = e_point; // 500   
double e_volume_buy = e_startVolume;  // 0.01
double e_volume_buy_real = e_volume_buy;
//bool e_found_buy = false;




void functionBuy(){
    double ask = SymbolInfoDouble(e_symbol_buy,SYMBOL_ASK); // 1.012364
    double point = SymbolInfoDouble(e_symbol_buy,SYMBOL_POINT); //  0.000001
    double point_c = e_point_b_buy * point ;
    double sl = ask - point_c;  // 
    double tp = ask + point_c; 
    trade.Buy(e_volume_buy,e_symbol_buy,ask,sl,tp,"BUY");
}


void functionSell(){
    double bid = SymbolInfoDouble(e_symbol_sell,SYMBOL_BID); // 1.012364
    double point = SymbolInfoDouble(e_symbol_sell,SYMBOL_POINT); //  0.000001
    double point_c = e_point_b_sell * point ;
    double sl = bid + point_c;  // 
    double tp = bid - point_c; 
    trade.Sell(e_volume_sell,e_symbol_sell,bid,sl,tp,"SELL");
}


void functionCheckPosition(){

bool e_found_sell = false;
bool e_found_buy = false;
   if(PositionsTotal() > 2){
      Print("--------Error Count Symbol---------");
      return ;
   }
   
   for(int i = 0; i<PositionsTotal(); i++){
     Print("Fooor LOOOOB");
     PositionSelectByTicket(PositionGetTicket(i));
     if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
      e_found_sell = true; // --
      e_symbol_sell = PositionGetString(POSITION_SYMBOL) ;  // +
      double e_point_sell = SymbolInfoDouble(e_symbol_sell,SYMBOL_POINT); //-
      double e_price_open_sell = PositionGetDouble(POSITION_PRICE_OPEN); //-
      double e_price_sl_sell = PositionGetDouble(POSITION_SL); // -
      double e__p = (e_price_open_sell - e_price_sl_sell)/e_point_sell; // -
      e_point_b_sell = (int)e__p; // +
      e_volume_sell = PositionGetDouble(POSITION_VOLUME); // +
      e_volume_sell_real = e_volume_sell;
     }else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL){
        e_found_buy = true; // --
        e_symbol_buy = PositionGetString(POSITION_SYMBOL) ;
        double e_point_buy = SymbolInfoDouble(e_symbol_buy,SYMBOL_POINT);
        double e_price_open_buy = PositionGetDouble(POSITION_PRICE_OPEN);
        double e_price_sl_buy = PositionGetDouble(POSITION_SL);
        double e__p = (e_price_open_buy - e_price_sl_buy)/e_point_buy;
        e_point_b_buy = (int)e__p ;
        e_volume_buy = PositionGetDouble(POSITION_VOLUME);
        e_volume_buy_real = e_volume_buy;
     }else{
          Print("--------Error Undefiend---------");
      return ;
     }
   }
   
   if(e_found_sell){
      if(e_symbol_sell != e_default_symbol_sell){
         Print("--------Error Symbol Sell---------");
         return ;
      }
   }else{
        
        //<----------Sell------------->
        functionSell();
        //</----------Sell------------->
   }
   
   
   if(e_found_buy){
      if(e_symbol_buy != e_default_symbol_buy){
         Print("--------Error Symbol Buy---------");
         return ;
      }
   }else{
        //<----------Buy------------->
            functionBuy();
        //</----------Buy------------->
   }
   
   

   if(PositionsTotal() == 2){
        Print("BYE");
        EventKillTimer();
   }
   


}







void function2(
   const MqlTradeTransaction& trans,
   const MqlTradeRequest& request,
   const MqlTradeResult& result
){





   #include <Trade\DealInfo.mqh>
   CDealInfo      m_deal;                       // object of CDealInfo class

  
   //--- get transaction type as enumeration value
   ENUM_TRADE_TRANSACTION_TYPE type=trans.type;
   
   //--- if transaction is result of addition of the transaction in history
   if(type==TRADE_TRANSACTION_DEAL_ADD)
     {
      if(HistoryDealSelect(trans.deal))
         m_deal.Ticket(trans.deal);
      else
      {
         Print("Error");
         return;
      }
      //---
      long reason=-1;
      if(!m_deal.InfoInteger(DEAL_REASON,reason))
        {
         Print("Error");
         return;
        }
        
      if(HistoryDealGetInteger(trans.deal,DEAL_TYPE) == DEAL_TYPE_SELL){
         // sell
         if((ENUM_DEAL_REASON)reason==DEAL_REASON_SL){

            // sell stop lose
            double p = e_point_b_sell + (e_point_b_sell*e_increasePoint);
            e_point_b_sell = (int)p;
            
            double v = e_volume_sell_real * e_increaseVolume;
            e_volume_sell_real = v;
            e_volume_sell = NormalizeDouble(v,2);


            functionSell();
         }
         else if((ENUM_DEAL_REASON)reason==DEAL_REASON_TP){
            // sell take profit
            e_point_b_sell = e_point; // 500
            e_volume_sell=e_startVolume; // 0.01
            e_volume_sell_real = e_volume_sell;
            functionSell();
         }
      }else if(HistoryDealGetInteger(trans.deal,DEAL_TYPE) == DEAL_TYPE_BUY){
         // Buy         
         if((ENUM_DEAL_REASON)reason==DEAL_REASON_SL){
            // buy stop lose
            double p = e_point_b_buy + (e_point_b_buy*e_increasePoint);
            e_point_b_buy = (int)p;
            double v = e_volume_buy_real * e_increaseVolume;
            e_volume_buy_real = v;
            e_volume_buy = NormalizeDouble(v,2);
            functionBuy();
         }
         else if((ENUM_DEAL_REASON)reason==DEAL_REASON_TP){
            // buy take profit
            e_point_b_buy = e_point; // 500   
            e_volume_buy = e_startVolume;  // 0.01
            e_volume_buy_real = e_volume_buy;
            functionBuy();
         }
      }
   }
   
}






int OnInit()
  {
//--- create timer
   EventSetTimer(60);
  

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
    functionCheckPosition();
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
//---
   function2(trans,request,result);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
//---
   
  }
//+------------------------------------------------------------------+
