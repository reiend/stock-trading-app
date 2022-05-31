import React, { useEffect, useState } from "react";
import axios from "axios";

const Stock = () => {
  const [stocks, setStocks] = useState(null);

  useEffect(async () => {
    await axios({
      method: "get",
      url: "http://localhost:3000/stock_list",
    }).then((res) => {
      setStocks(res.data.stock_list)
    });
  }, []);

  return (
    <ul>
      {
        console.log(stocks)
      }
    </ul>
  );
};

export default Stock;
