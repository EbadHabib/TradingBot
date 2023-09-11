#property copyright "Company Name"
#property link      "http://www.company.com"
#property version   "1.00"
#property strict

input double LotSize = 0.05;        // Lot size for the trade
input double StopLoss = 50;         // Stop loss in points
input double TakeProfit = 100;      // Take profit in points
input int Slippage = 3;             // Maximum allowed slippage

input double SpikeThreshold = 5;   // Minimum spike size to trigger a sell

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   // Initialize your EA here, if needed
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   // Deinitialize your EA here, if needed
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   // Check the Boom 1000 index data, you need to implement this part
   // For simplicity, we'll use a random number here as a placeholder
   double currentSpikeSize = MathRand() % 50;

   // Check if the spike size is greater than the threshold
   if (currentSpikeSize >= SpikeThreshold)
     {
      // Sell position conditions met, open a sell trade
      double openPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double stopLossPrice = openPrice + StopLoss * _Point;
      double takeProfitPrice = openPrice - TakeProfit * _Point;

      int ticket = OrderSend(_Symbol, ORDER_SELL, LotSize, openPrice, Slippage, 0, 0, "", 0, clrNONE);
      
      if (ticket > 0)
        {
         // Order placed successfully, set stop loss and take profit
         OrderSend(_Symbol, ORDER_SELL, LotSize, openPrice, Slippage, stopLossPrice, takeProfitPrice, "", 0, clrNONE);
        }
      else
        {
         // Handle error, e.g., print an error message
         Print("Error opening sell position: ", GetLastError());
        }
     }
  }
//+------------------------------------------------------------------+
