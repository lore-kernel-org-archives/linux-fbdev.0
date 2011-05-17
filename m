From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Tue, 17 May 2011 11:59:40 +0000
Subject: i80 (Intel 8080-like) command interface to LCDs - how to implement
Message-Id: <201105171359.43658.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?iso-8859-1?q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Hi,

I'm trying to find the best way on implementing an i80 interface (especially 
the command mode) between a s3c2416 and an AUO-K1900 (epaper controller).

On the host side it is usable at least in all Samsung SoCs following the 
S3C2443 and on the device side I've found, apart from the K1900, for example 
the ili9320 and STM32F10xxx displays controllers using this interface.

It looks a bit like a cross between SPI and I2C but fits neither category - at 
least for my understanding.

pins/pins consist of:
CS ... chip-select
RS ... control or data register select
WE ... write enable
RE ... read enable
D0-Dn ... data 0-n for variing values of n
(I've seen up to 18 data bits)


commands can look like:
(* set command mode)
* set chip-select

* set RS to control (mostly low)
* set WE to high
* write command to D
* unset WE
* set RS to data

* set WE
* write data to D
* unset WE
* set WE
* write data to D
* unset WE
...
* set RE
* read data from D
* unset RE
...
* unset chip-select
(* unset command mode)

the fourth possible state (read-control) is also used by the ili9320.

looks a lot like an i2c-transfer, i.e. something like
{
  { WC, 6001 }, //for write-control
  { WD, 576 }, //for write-data
  { WD, 12 }, //for write-data
  { RD, *buf } //for read-data
}
could represent the above command-sequence.


So, is this a new bus type or does it fit somehow into spi or i2c or some other 
bus-type I don't know yet? Or, does code for i80 exist somewhere I haven't 
looked yet?

Thanks in advance
Heiko
