From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 24 Dec 2003 16:34:07 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA064F.9020303@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>  <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>  <1070410792.21174.83.camel@gaston>  <3FE8CCE3.4010709@undead.cc>  <1072230310.739.25.camel@gaston>  <3FE90001.3080207@undead.cc>  <1072236683.739.32.camel@gaston>  <3FE919E1.7050609@undead.cc> <1072242753.820.41.camel@gaston> <3FE92BFD.8020104@undead.cc> <Pine.GSO.4.58.0312241309040.1638@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020507050705050905080002"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZGeG-0004Vo-UF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 13:34:32 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZGeF-0003zq-DX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 13:34:31 -0800
In-Reply-To: <Pine.GSO.4.58.0312241309040.1638@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020507050705050905080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Geert Uytterhoeven wrote:

>I know there are some issues with the penguin in 24 bpp, though (penguin may
>have blue feet and mouth).
>  
>

I've done some digging and it's definitely because of how many palette 
entries are updated for the 565 mode.  What's the proper number of 
entries that need to be updated for 565 mode, 32 or 64?   I'll have to 
check what the nvidia driver expects.  I can't test 24 bpp as the driver 
won't do that currently.

I've included the output of a simulation of the redeonfb_set_colreg 
routine so you can see what I mean.  I you look at the DAC dump you can 
see that only the first 32 green entries actually get a value.

John


--------------020507050705050905080002
Content-Type: text/plain;
 name="test_16_16_032_064"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_16_16_032_064"

PARM: 00    R: 00 (Par:00)  G: 00 (Par:00)  B: 00 (Par:00)  
OUT1: 00    R: 00 (Pal:00)  G: 00 (Par:00)  B: 00 (Pal:00)  
OUT2: 00    R: 00 (Par:00)  G: 00 (Pal:00)  B: 00 (Par:00)  

PARM: 01    R: 01 (Par:01)  G: 01 (Par:01)  B: 01 (Par:01)  
OUT1: 04    R: 00 (Pal:00)  G: 01 (Par:01)  B: 00 (Pal:00)  
*** Palette green 02 read uninitialized data ***
OUT2: 08    R: 01 (Par:01)  G: !! (Pal:02)  B: 01 (Par:01)  

PARM: 02    R: 02 (Par:02)  G: 02 (Par:02)  B: 02 (Par:02)  
OUT1: 08    R: 01 (Pal:01)  G: 02 (Par:02)  B: 01 (Pal:01)  
*** Palette green 04 read uninitialized data ***
OUT2: 10    R: 02 (Par:02)  G: !! (Pal:04)  B: 02 (Par:02)  

PARM: 03    R: 03 (Par:03)  G: 03 (Par:03)  B: 03 (Par:03)  
OUT1: 0c    R: 01 (Pal:01)  G: 03 (Par:03)  B: 01 (Pal:01)  
*** Palette green 06 read uninitialized data ***
OUT2: 18    R: 03 (Par:03)  G: !! (Pal:06)  B: 03 (Par:03)  

PARM: 04    R: 04 (Par:04)  G: 04 (Par:04)  B: 04 (Par:04)  
OUT1: 10    R: 02 (Pal:02)  G: 04 (Par:04)  B: 02 (Pal:02)  
*** Palette green 08 read uninitialized data ***
OUT2: 20    R: 04 (Par:04)  G: !! (Pal:08)  B: 04 (Par:04)  

PARM: 05    R: 05 (Par:05)  G: 05 (Par:05)  B: 05 (Par:05)  
OUT1: 14    R: 02 (Pal:02)  G: 05 (Par:05)  B: 02 (Pal:02)  
*** Palette green 0a read uninitialized data ***
OUT2: 28    R: 05 (Par:05)  G: !! (Pal:0a)  B: 05 (Par:05)  

PARM: 06    R: 06 (Par:06)  G: 06 (Par:06)  B: 06 (Par:06)  
OUT1: 18    R: 03 (Pal:03)  G: 06 (Par:06)  B: 03 (Pal:03)  
*** Palette green 0c read uninitialized data ***
OUT2: 30    R: 06 (Par:06)  G: !! (Pal:0c)  B: 06 (Par:06)  

PARM: 07    R: 07 (Par:07)  G: 07 (Par:07)  B: 07 (Par:07)  
OUT1: 1c    R: 03 (Pal:03)  G: 07 (Par:07)  B: 03 (Pal:03)  
*** Palette green 0e read uninitialized data ***
OUT2: 38    R: 07 (Par:07)  G: !! (Pal:0e)  B: 07 (Par:07)  

PARM: 08    R: 08 (Par:08)  G: 08 (Par:08)  B: 08 (Par:08)  
OUT1: 20    R: 04 (Pal:04)  G: 08 (Par:08)  B: 04 (Pal:04)  
*** Palette green 10 read uninitialized data ***
OUT2: 40    R: 08 (Par:08)  G: !! (Pal:10)  B: 08 (Par:08)  

PARM: 09    R: 09 (Par:09)  G: 09 (Par:09)  B: 09 (Par:09)  
OUT1: 24    R: 04 (Pal:04)  G: 09 (Par:09)  B: 04 (Pal:04)  
*** Palette green 12 read uninitialized data ***
OUT2: 48    R: 09 (Par:09)  G: !! (Pal:12)  B: 09 (Par:09)  

PARM: 0a    R: 0a (Par:0a)  G: 0a (Par:0a)  B: 0a (Par:0a)  
OUT1: 28    R: 05 (Pal:05)  G: 0a (Par:0a)  B: 05 (Pal:05)  
*** Palette green 14 read uninitialized data ***
OUT2: 50    R: 0a (Par:0a)  G: !! (Pal:14)  B: 0a (Par:0a)  

PARM: 0b    R: 0b (Par:0b)  G: 0b (Par:0b)  B: 0b (Par:0b)  
OUT1: 2c    R: 05 (Pal:05)  G: 0b (Par:0b)  B: 05 (Pal:05)  
*** Palette green 16 read uninitialized data ***
OUT2: 58    R: 0b (Par:0b)  G: !! (Pal:16)  B: 0b (Par:0b)  

PARM: 0c    R: 0c (Par:0c)  G: 0c (Par:0c)  B: 0c (Par:0c)  
OUT1: 30    R: 06 (Pal:06)  G: 0c (Par:0c)  B: 06 (Pal:06)  
*** Palette green 18 read uninitialized data ***
OUT2: 60    R: 0c (Par:0c)  G: !! (Pal:18)  B: 0c (Par:0c)  

PARM: 0d    R: 0d (Par:0d)  G: 0d (Par:0d)  B: 0d (Par:0d)  
OUT1: 34    R: 06 (Pal:06)  G: 0d (Par:0d)  B: 06 (Pal:06)  
*** Palette green 1a read uninitialized data ***
OUT2: 68    R: 0d (Par:0d)  G: !! (Pal:1a)  B: 0d (Par:0d)  

PARM: 0e    R: 0e (Par:0e)  G: 0e (Par:0e)  B: 0e (Par:0e)  
OUT1: 38    R: 07 (Pal:07)  G: 0e (Par:0e)  B: 07 (Pal:07)  
*** Palette green 1c read uninitialized data ***
OUT2: 70    R: 0e (Par:0e)  G: !! (Pal:1c)  B: 0e (Par:0e)  

PARM: 0f    R: 0f (Par:0f)  G: 0f (Par:0f)  B: 0f (Par:0f)  
OUT1: 3c    R: 07 (Pal:07)  G: 0f (Par:0f)  B: 07 (Pal:07)  
*** Palette green 1e read uninitialized data ***
OUT2: 78    R: 0f (Par:0f)  G: !! (Pal:1e)  B: 0f (Par:0f)  

PARM: 10    R: 10 (Par:10)  G: 10 (Par:10)  B: 10 (Par:10)  
OUT1: 40    R: 08 (Pal:08)  G: 10 (Par:10)  B: 08 (Pal:08)  
*** Palette green 20 read uninitialized data ***
OUT2: 80    R: 10 (Par:10)  G: !! (Pal:20)  B: 10 (Par:10)  

PARM: 11    R: 11 (Par:11)  G: 11 (Par:11)  B: 11 (Par:11)  
OUT1: 44    R: 08 (Pal:08)  G: 11 (Par:11)  B: 08 (Pal:08)  
*** Palette green 22 read uninitialized data ***
OUT2: 88    R: 11 (Par:11)  G: !! (Pal:22)  B: 11 (Par:11)  

PARM: 12    R: 12 (Par:12)  G: 12 (Par:12)  B: 12 (Par:12)  
OUT1: 48    R: 09 (Pal:09)  G: 12 (Par:12)  B: 09 (Pal:09)  
*** Palette green 24 read uninitialized data ***
OUT2: 90    R: 12 (Par:12)  G: !! (Pal:24)  B: 12 (Par:12)  

PARM: 13    R: 13 (Par:13)  G: 13 (Par:13)  B: 13 (Par:13)  
OUT1: 4c    R: 09 (Pal:09)  G: 13 (Par:13)  B: 09 (Pal:09)  
*** Palette green 26 read uninitialized data ***
OUT2: 98    R: 13 (Par:13)  G: !! (Pal:26)  B: 13 (Par:13)  

PARM: 14    R: 14 (Par:14)  G: 14 (Par:14)  B: 14 (Par:14)  
OUT1: 50    R: 0a (Pal:0a)  G: 14 (Par:14)  B: 0a (Pal:0a)  
*** Palette green 28 read uninitialized data ***
OUT2: a0    R: 14 (Par:14)  G: !! (Pal:28)  B: 14 (Par:14)  

PARM: 15    R: 15 (Par:15)  G: 15 (Par:15)  B: 15 (Par:15)  
OUT1: 54    R: 0a (Pal:0a)  G: 15 (Par:15)  B: 0a (Pal:0a)  
*** Palette green 2a read uninitialized data ***
OUT2: a8    R: 15 (Par:15)  G: !! (Pal:2a)  B: 15 (Par:15)  

PARM: 16    R: 16 (Par:16)  G: 16 (Par:16)  B: 16 (Par:16)  
OUT1: 58    R: 0b (Pal:0b)  G: 16 (Par:16)  B: 0b (Pal:0b)  
*** Palette green 2c read uninitialized data ***
OUT2: b0    R: 16 (Par:16)  G: !! (Pal:2c)  B: 16 (Par:16)  

PARM: 17    R: 17 (Par:17)  G: 17 (Par:17)  B: 17 (Par:17)  
OUT1: 5c    R: 0b (Pal:0b)  G: 17 (Par:17)  B: 0b (Pal:0b)  
*** Palette green 2e read uninitialized data ***
OUT2: b8    R: 17 (Par:17)  G: !! (Pal:2e)  B: 17 (Par:17)  

PARM: 18    R: 18 (Par:18)  G: 18 (Par:18)  B: 18 (Par:18)  
OUT1: 60    R: 0c (Pal:0c)  G: 18 (Par:18)  B: 0c (Pal:0c)  
*** Palette green 30 read uninitialized data ***
OUT2: c0    R: 18 (Par:18)  G: !! (Pal:30)  B: 18 (Par:18)  

PARM: 19    R: 19 (Par:19)  G: 19 (Par:19)  B: 19 (Par:19)  
OUT1: 64    R: 0c (Pal:0c)  G: 19 (Par:19)  B: 0c (Pal:0c)  
*** Palette green 32 read uninitialized data ***
OUT2: c8    R: 19 (Par:19)  G: !! (Pal:32)  B: 19 (Par:19)  

PARM: 1a    R: 1a (Par:1a)  G: 1a (Par:1a)  B: 1a (Par:1a)  
OUT1: 68    R: 0d (Pal:0d)  G: 1a (Par:1a)  B: 0d (Pal:0d)  
*** Palette green 34 read uninitialized data ***
OUT2: d0    R: 1a (Par:1a)  G: !! (Pal:34)  B: 1a (Par:1a)  

PARM: 1b    R: 1b (Par:1b)  G: 1b (Par:1b)  B: 1b (Par:1b)  
OUT1: 6c    R: 0d (Pal:0d)  G: 1b (Par:1b)  B: 0d (Pal:0d)  
*** Palette green 36 read uninitialized data ***
OUT2: d8    R: 1b (Par:1b)  G: !! (Pal:36)  B: 1b (Par:1b)  

PARM: 1c    R: 1c (Par:1c)  G: 1c (Par:1c)  B: 1c (Par:1c)  
OUT1: 70    R: 0e (Pal:0e)  G: 1c (Par:1c)  B: 0e (Pal:0e)  
*** Palette green 38 read uninitialized data ***
OUT2: e0    R: 1c (Par:1c)  G: !! (Pal:38)  B: 1c (Par:1c)  

PARM: 1d    R: 1d (Par:1d)  G: 1d (Par:1d)  B: 1d (Par:1d)  
OUT1: 74    R: 0e (Pal:0e)  G: 1d (Par:1d)  B: 0e (Pal:0e)  
*** Palette green 3a read uninitialized data ***
OUT2: e8    R: 1d (Par:1d)  G: !! (Pal:3a)  B: 1d (Par:1d)  

PARM: 1e    R: 1e (Par:1e)  G: 1e (Par:1e)  B: 1e (Par:1e)  
OUT1: 78    R: 0f (Pal:0f)  G: 1e (Par:1e)  B: 0f (Pal:0f)  
*** Palette green 3c read uninitialized data ***
OUT2: f0    R: 1e (Par:1e)  G: !! (Pal:3c)  B: 1e (Par:1e)  

PARM: 1f    R: 1f (Par:1f)  G: 1f (Par:1f)  B: 1f (Par:1f)  
OUT1: 7c    R: 0f (Pal:0f)  G: 1f (Par:1f)  B: 0f (Pal:0f)  
*** Palette green 3e read uninitialized data ***
OUT2: f8    R: 1f (Par:1f)  G: !! (Pal:3e)  B: 1f (Par:1f)  

PARM: 20    R: 00 (Par:20)  G: 00 (Par:20)  B: 00 (Par:20)  
OUT1: 80    R: 10 (Pal:10)  G: 00 (Par:20)  B: 10 (Pal:10)  
*** Palette green 40 read uninitialized data ***

PARM: 21    R: 00 (Par:21)  G: 00 (Par:21)  B: 00 (Par:21)  
OUT1: 84    R: 10 (Pal:10)  G: 00 (Par:21)  B: 10 (Pal:10)  
*** Palette green 42 read uninitialized data ***

PARM: 22    R: 00 (Par:22)  G: 00 (Par:22)  B: 00 (Par:22)  
OUT1: 88    R: 11 (Pal:11)  G: 00 (Par:22)  B: 11 (Pal:11)  
*** Palette green 44 read uninitialized data ***

PARM: 23    R: 00 (Par:23)  G: 00 (Par:23)  B: 00 (Par:23)  
OUT1: 8c    R: 11 (Pal:11)  G: 00 (Par:23)  B: 11 (Pal:11)  
*** Palette green 46 read uninitialized data ***

PARM: 24    R: 00 (Par:24)  G: 00 (Par:24)  B: 00 (Par:24)  
OUT1: 90    R: 12 (Pal:12)  G: 00 (Par:24)  B: 12 (Pal:12)  
*** Palette green 48 read uninitialized data ***

PARM: 25    R: 00 (Par:25)  G: 00 (Par:25)  B: 00 (Par:25)  
OUT1: 94    R: 12 (Pal:12)  G: 00 (Par:25)  B: 12 (Pal:12)  
*** Palette green 4a read uninitialized data ***

PARM: 26    R: 00 (Par:26)  G: 00 (Par:26)  B: 00 (Par:26)  
OUT1: 98    R: 13 (Pal:13)  G: 00 (Par:26)  B: 13 (Pal:13)  
*** Palette green 4c read uninitialized data ***

PARM: 27    R: 00 (Par:27)  G: 00 (Par:27)  B: 00 (Par:27)  
OUT1: 9c    R: 13 (Pal:13)  G: 00 (Par:27)  B: 13 (Pal:13)  
*** Palette green 4e read uninitialized data ***

PARM: 28    R: 00 (Par:28)  G: 00 (Par:28)  B: 00 (Par:28)  
OUT1: a0    R: 14 (Pal:14)  G: 00 (Par:28)  B: 14 (Pal:14)  
*** Palette green 50 read uninitialized data ***

PARM: 29    R: 00 (Par:29)  G: 00 (Par:29)  B: 00 (Par:29)  
OUT1: a4    R: 14 (Pal:14)  G: 00 (Par:29)  B: 14 (Pal:14)  
*** Palette green 52 read uninitialized data ***

PARM: 2a    R: 00 (Par:2a)  G: 00 (Par:2a)  B: 00 (Par:2a)  
OUT1: a8    R: 15 (Pal:15)  G: 00 (Par:2a)  B: 15 (Pal:15)  
*** Palette green 54 read uninitialized data ***

PARM: 2b    R: 00 (Par:2b)  G: 00 (Par:2b)  B: 00 (Par:2b)  
OUT1: ac    R: 15 (Pal:15)  G: 00 (Par:2b)  B: 15 (Pal:15)  
*** Palette green 56 read uninitialized data ***

PARM: 2c    R: 00 (Par:2c)  G: 00 (Par:2c)  B: 00 (Par:2c)  
OUT1: b0    R: 16 (Pal:16)  G: 00 (Par:2c)  B: 16 (Pal:16)  
*** Palette green 58 read uninitialized data ***

PARM: 2d    R: 00 (Par:2d)  G: 00 (Par:2d)  B: 00 (Par:2d)  
OUT1: b4    R: 16 (Pal:16)  G: 00 (Par:2d)  B: 16 (Pal:16)  
*** Palette green 5a read uninitialized data ***

PARM: 2e    R: 00 (Par:2e)  G: 00 (Par:2e)  B: 00 (Par:2e)  
OUT1: b8    R: 17 (Pal:17)  G: 00 (Par:2e)  B: 17 (Pal:17)  
*** Palette green 5c read uninitialized data ***

PARM: 2f    R: 00 (Par:2f)  G: 00 (Par:2f)  B: 00 (Par:2f)  
OUT1: bc    R: 17 (Pal:17)  G: 00 (Par:2f)  B: 17 (Pal:17)  
*** Palette green 5e read uninitialized data ***

PARM: 30    R: 00 (Par:30)  G: 00 (Par:30)  B: 00 (Par:30)  
OUT1: c0    R: 18 (Pal:18)  G: 00 (Par:30)  B: 18 (Pal:18)  
*** Palette green 60 read uninitialized data ***

PARM: 31    R: 00 (Par:31)  G: 00 (Par:31)  B: 00 (Par:31)  
OUT1: c4    R: 18 (Pal:18)  G: 00 (Par:31)  B: 18 (Pal:18)  
*** Palette green 62 read uninitialized data ***

PARM: 32    R: 00 (Par:32)  G: 00 (Par:32)  B: 00 (Par:32)  
OUT1: c8    R: 19 (Pal:19)  G: 00 (Par:32)  B: 19 (Pal:19)  
*** Palette green 64 read uninitialized data ***

PARM: 33    R: 00 (Par:33)  G: 00 (Par:33)  B: 00 (Par:33)  
OUT1: cc    R: 19 (Pal:19)  G: 00 (Par:33)  B: 19 (Pal:19)  
*** Palette green 66 read uninitialized data ***

PARM: 34    R: 00 (Par:34)  G: 00 (Par:34)  B: 00 (Par:34)  
OUT1: d0    R: 1a (Pal:1a)  G: 00 (Par:34)  B: 1a (Pal:1a)  
*** Palette green 68 read uninitialized data ***

PARM: 35    R: 00 (Par:35)  G: 00 (Par:35)  B: 00 (Par:35)  
OUT1: d4    R: 1a (Pal:1a)  G: 00 (Par:35)  B: 1a (Pal:1a)  
*** Palette green 6a read uninitialized data ***

PARM: 36    R: 00 (Par:36)  G: 00 (Par:36)  B: 00 (Par:36)  
OUT1: d8    R: 1b (Pal:1b)  G: 00 (Par:36)  B: 1b (Pal:1b)  
*** Palette green 6c read uninitialized data ***

PARM: 37    R: 00 (Par:37)  G: 00 (Par:37)  B: 00 (Par:37)  
OUT1: dc    R: 1b (Pal:1b)  G: 00 (Par:37)  B: 1b (Pal:1b)  
*** Palette green 6e read uninitialized data ***

PARM: 38    R: 00 (Par:38)  G: 00 (Par:38)  B: 00 (Par:38)  
OUT1: e0    R: 1c (Pal:1c)  G: 00 (Par:38)  B: 1c (Pal:1c)  
*** Palette green 70 read uninitialized data ***

PARM: 39    R: 00 (Par:39)  G: 00 (Par:39)  B: 00 (Par:39)  
OUT1: e4    R: 1c (Pal:1c)  G: 00 (Par:39)  B: 1c (Pal:1c)  
*** Palette green 72 read uninitialized data ***

PARM: 3a    R: 00 (Par:3a)  G: 00 (Par:3a)  B: 00 (Par:3a)  
OUT1: e8    R: 1d (Pal:1d)  G: 00 (Par:3a)  B: 1d (Pal:1d)  
*** Palette green 74 read uninitialized data ***

PARM: 3b    R: 00 (Par:3b)  G: 00 (Par:3b)  B: 00 (Par:3b)  
OUT1: ec    R: 1d (Pal:1d)  G: 00 (Par:3b)  B: 1d (Pal:1d)  
*** Palette green 76 read uninitialized data ***

PARM: 3c    R: 00 (Par:3c)  G: 00 (Par:3c)  B: 00 (Par:3c)  
OUT1: f0    R: 1e (Pal:1e)  G: 00 (Par:3c)  B: 1e (Pal:1e)  
*** Palette green 78 read uninitialized data ***

PARM: 3d    R: 00 (Par:3d)  G: 00 (Par:3d)  B: 00 (Par:3d)  
OUT1: f4    R: 1e (Pal:1e)  G: 00 (Par:3d)  B: 1e (Pal:1e)  
*** Palette green 7a read uninitialized data ***

PARM: 3e    R: 00 (Par:3e)  G: 00 (Par:3e)  B: 00 (Par:3e)  
OUT1: f8    R: 1f (Pal:1f)  G: 00 (Par:3e)  B: 1f (Pal:1f)  
*** Palette green 7c read uninitialized data ***

PARM: 3f    R: 00 (Par:3f)  G: 00 (Par:3f)  B: 00 (Par:3f)  
OUT1: fc    R: 1f (Pal:1f)  G: 00 (Par:3f)  B: 1f (Pal:1f)  
*** Palette green 7e read uninitialized data ***



DAC Dump:

00  OUT2  R: 00 (Par:00)  G: 00 (Pal:00)  B: 00 (Par:00)  
01        R: --           G: --           B: --           
02        R: --           G: --           B: --           
03        R: --           G: --           B: --           
04  OUT1  R: 00 (Pal:00)  G: 01 (Par:01)  B: 00 (Pal:00)  
05        R: --           G: --           B: --           
06        R: --           G: --           B: --           
07        R: --           G: --           B: --           
08  OUT1  R: 01 (Pal:01)  G: 02 (Par:02)  B: 01 (Pal:01)  
09        R: --           G: --           B: --           
0a        R: --           G: --           B: --           
0b        R: --           G: --           B: --           
0c  OUT1  R: 01 (Pal:01)  G: 03 (Par:03)  B: 01 (Pal:01)  
0d        R: --           G: --           B: --           
0e        R: --           G: --           B: --           
0f        R: --           G: --           B: --           
10  OUT1  R: 02 (Pal:02)  G: 04 (Par:04)  B: 02 (Pal:02)  
11        R: --           G: --           B: --           
12        R: --           G: --           B: --           
13        R: --           G: --           B: --           
14  OUT1  R: 02 (Pal:02)  G: 05 (Par:05)  B: 02 (Pal:02)  
15        R: --           G: --           B: --           
16        R: --           G: --           B: --           
17        R: --           G: --           B: --           
18  OUT1  R: 03 (Pal:03)  G: 06 (Par:06)  B: 03 (Pal:03)  
19        R: --           G: --           B: --           
1a        R: --           G: --           B: --           
1b        R: --           G: --           B: --           
1c  OUT1  R: 03 (Pal:03)  G: 07 (Par:07)  B: 03 (Pal:03)  
1d        R: --           G: --           B: --           
1e        R: --           G: --           B: --           
1f        R: --           G: --           B: --           
20  OUT1  R: 04 (Pal:04)  G: 08 (Par:08)  B: 04 (Pal:04)  
21        R: --           G: --           B: --           
22        R: --           G: --           B: --           
23        R: --           G: --           B: --           
24  OUT1  R: 04 (Pal:04)  G: 09 (Par:09)  B: 04 (Pal:04)  
25        R: --           G: --           B: --           
26        R: --           G: --           B: --           
27        R: --           G: --           B: --           
28  OUT1  R: 05 (Pal:05)  G: 0a (Par:0a)  B: 05 (Pal:05)  
29        R: --           G: --           B: --           
2a        R: --           G: --           B: --           
2b        R: --           G: --           B: --           
2c  OUT1  R: 05 (Pal:05)  G: 0b (Par:0b)  B: 05 (Pal:05)  
2d        R: --           G: --           B: --           
2e        R: --           G: --           B: --           
2f        R: --           G: --           B: --           
30  OUT1  R: 06 (Pal:06)  G: 0c (Par:0c)  B: 06 (Pal:06)  
31        R: --           G: --           B: --           
32        R: --           G: --           B: --           
33        R: --           G: --           B: --           
34  OUT1  R: 06 (Pal:06)  G: 0d (Par:0d)  B: 06 (Pal:06)  
35        R: --           G: --           B: --           
36        R: --           G: --           B: --           
37        R: --           G: --           B: --           
38  OUT1  R: 07 (Pal:07)  G: 0e (Par:0e)  B: 07 (Pal:07)  
39        R: --           G: --           B: --           
3a        R: --           G: --           B: --           
3b        R: --           G: --           B: --           
3c  OUT1  R: 07 (Pal:07)  G: 0f (Par:0f)  B: 07 (Pal:07)  
3d        R: --           G: --           B: --           
3e        R: --           G: --           B: --           
3f        R: --           G: --           B: --           
40  OUT1  R: 08 (Pal:08)  G: 10 (Par:10)  B: 08 (Pal:08)  
41        R: --           G: --           B: --           
42        R: --           G: --           B: --           
43        R: --           G: --           B: --           
44  OUT1  R: 08 (Pal:08)  G: 11 (Par:11)  B: 08 (Pal:08)  
45        R: --           G: --           B: --           
46        R: --           G: --           B: --           
47        R: --           G: --           B: --           
48  OUT1  R: 09 (Pal:09)  G: 12 (Par:12)  B: 09 (Pal:09)  
49        R: --           G: --           B: --           
4a        R: --           G: --           B: --           
4b        R: --           G: --           B: --           
4c  OUT1  R: 09 (Pal:09)  G: 13 (Par:13)  B: 09 (Pal:09)  
4d        R: --           G: --           B: --           
4e        R: --           G: --           B: --           
4f        R: --           G: --           B: --           
50  OUT1  R: 0a (Pal:0a)  G: 14 (Par:14)  B: 0a (Pal:0a)  
51        R: --           G: --           B: --           
52        R: --           G: --           B: --           
53        R: --           G: --           B: --           
54  OUT1  R: 0a (Pal:0a)  G: 15 (Par:15)  B: 0a (Pal:0a)  
55        R: --           G: --           B: --           
56        R: --           G: --           B: --           
57        R: --           G: --           B: --           
58  OUT1  R: 0b (Pal:0b)  G: 16 (Par:16)  B: 0b (Pal:0b)  
59        R: --           G: --           B: --           
5a        R: --           G: --           B: --           
5b        R: --           G: --           B: --           
5c  OUT1  R: 0b (Pal:0b)  G: 17 (Par:17)  B: 0b (Pal:0b)  
5d        R: --           G: --           B: --           
5e        R: --           G: --           B: --           
5f        R: --           G: --           B: --           
60  OUT1  R: 0c (Pal:0c)  G: 18 (Par:18)  B: 0c (Pal:0c)  
61        R: --           G: --           B: --           
62        R: --           G: --           B: --           
63        R: --           G: --           B: --           
64  OUT1  R: 0c (Pal:0c)  G: 19 (Par:19)  B: 0c (Pal:0c)  
65        R: --           G: --           B: --           
66        R: --           G: --           B: --           
67        R: --           G: --           B: --           
68  OUT1  R: 0d (Pal:0d)  G: 1a (Par:1a)  B: 0d (Pal:0d)  
69        R: --           G: --           B: --           
6a        R: --           G: --           B: --           
6b        R: --           G: --           B: --           
6c  OUT1  R: 0d (Pal:0d)  G: 1b (Par:1b)  B: 0d (Pal:0d)  
6d        R: --           G: --           B: --           
6e        R: --           G: --           B: --           
6f        R: --           G: --           B: --           
70  OUT1  R: 0e (Pal:0e)  G: 1c (Par:1c)  B: 0e (Pal:0e)  
71        R: --           G: --           B: --           
72        R: --           G: --           B: --           
73        R: --           G: --           B: --           
74  OUT1  R: 0e (Pal:0e)  G: 1d (Par:1d)  B: 0e (Pal:0e)  
75        R: --           G: --           B: --           
76        R: --           G: --           B: --           
77        R: --           G: --           B: --           
78  OUT1  R: 0f (Pal:0f)  G: 1e (Par:1e)  B: 0f (Pal:0f)  
79        R: --           G: --           B: --           
7a        R: --           G: --           B: --           
7b        R: --           G: --           B: --           
7c  OUT1  R: 0f (Pal:0f)  G: 1f (Par:1f)  B: 0f (Pal:0f)  
7d        R: --           G: --           B: --           
7e        R: --           G: --           B: --           
7f        R: --           G: --           B: --           
80  OUT1  R: 10 (Pal:10)  G: 00 (Par:20)  B: 10 (Pal:10)  
81        R: --           G: --           B: --           
82        R: --           G: --           B: --           
83        R: --           G: --           B: --           
84  OUT1  R: 10 (Pal:10)  G: 00 (Par:21)  B: 10 (Pal:10)  
85        R: --           G: --           B: --           
86        R: --           G: --           B: --           
87        R: --           G: --           B: --           
88  OUT1  R: 11 (Pal:11)  G: 00 (Par:22)  B: 11 (Pal:11)  
89        R: --           G: --           B: --           
8a        R: --           G: --           B: --           
8b        R: --           G: --           B: --           
8c  OUT1  R: 11 (Pal:11)  G: 00 (Par:23)  B: 11 (Pal:11)  
8d        R: --           G: --           B: --           
8e        R: --           G: --           B: --           
8f        R: --           G: --           B: --           
90  OUT1  R: 12 (Pal:12)  G: 00 (Par:24)  B: 12 (Pal:12)  
91        R: --           G: --           B: --           
92        R: --           G: --           B: --           
93        R: --           G: --           B: --           
94  OUT1  R: 12 (Pal:12)  G: 00 (Par:25)  B: 12 (Pal:12)  
95        R: --           G: --           B: --           
96        R: --           G: --           B: --           
97        R: --           G: --           B: --           
98  OUT1  R: 13 (Pal:13)  G: 00 (Par:26)  B: 13 (Pal:13)  
99        R: --           G: --           B: --           
9a        R: --           G: --           B: --           
9b        R: --           G: --           B: --           
9c  OUT1  R: 13 (Pal:13)  G: 00 (Par:27)  B: 13 (Pal:13)  
9d        R: --           G: --           B: --           
9e        R: --           G: --           B: --           
9f        R: --           G: --           B: --           
a0  OUT1  R: 14 (Pal:14)  G: 00 (Par:28)  B: 14 (Pal:14)  
a1        R: --           G: --           B: --           
a2        R: --           G: --           B: --           
a3        R: --           G: --           B: --           
a4  OUT1  R: 14 (Pal:14)  G: 00 (Par:29)  B: 14 (Pal:14)  
a5        R: --           G: --           B: --           
a6        R: --           G: --           B: --           
a7        R: --           G: --           B: --           
a8  OUT1  R: 15 (Pal:15)  G: 00 (Par:2a)  B: 15 (Pal:15)  
a9        R: --           G: --           B: --           
aa        R: --           G: --           B: --           
ab        R: --           G: --           B: --           
ac  OUT1  R: 15 (Pal:15)  G: 00 (Par:2b)  B: 15 (Pal:15)  
ad        R: --           G: --           B: --           
ae        R: --           G: --           B: --           
af        R: --           G: --           B: --           
b0  OUT1  R: 16 (Pal:16)  G: 00 (Par:2c)  B: 16 (Pal:16)  
b1        R: --           G: --           B: --           
b2        R: --           G: --           B: --           
b3        R: --           G: --           B: --           
b4  OUT1  R: 16 (Pal:16)  G: 00 (Par:2d)  B: 16 (Pal:16)  
b5        R: --           G: --           B: --           
b6        R: --           G: --           B: --           
b7        R: --           G: --           B: --           
b8  OUT1  R: 17 (Pal:17)  G: 00 (Par:2e)  B: 17 (Pal:17)  
b9        R: --           G: --           B: --           
ba        R: --           G: --           B: --           
bb        R: --           G: --           B: --           
bc  OUT1  R: 17 (Pal:17)  G: 00 (Par:2f)  B: 17 (Pal:17)  
bd        R: --           G: --           B: --           
be        R: --           G: --           B: --           
bf        R: --           G: --           B: --           
c0  OUT1  R: 18 (Pal:18)  G: 00 (Par:30)  B: 18 (Pal:18)  
c1        R: --           G: --           B: --           
c2        R: --           G: --           B: --           
c3        R: --           G: --           B: --           
c4  OUT1  R: 18 (Pal:18)  G: 00 (Par:31)  B: 18 (Pal:18)  
c5        R: --           G: --           B: --           
c6        R: --           G: --           B: --           
c7        R: --           G: --           B: --           
c8  OUT1  R: 19 (Pal:19)  G: 00 (Par:32)  B: 19 (Pal:19)  
c9        R: --           G: --           B: --           
ca        R: --           G: --           B: --           
cb        R: --           G: --           B: --           
cc  OUT1  R: 19 (Pal:19)  G: 00 (Par:33)  B: 19 (Pal:19)  
cd        R: --           G: --           B: --           
ce        R: --           G: --           B: --           
cf        R: --           G: --           B: --           
d0  OUT1  R: 1a (Pal:1a)  G: 00 (Par:34)  B: 1a (Pal:1a)  
d1        R: --           G: --           B: --           
d2        R: --           G: --           B: --           
d3        R: --           G: --           B: --           
d4  OUT1  R: 1a (Pal:1a)  G: 00 (Par:35)  B: 1a (Pal:1a)  
d5        R: --           G: --           B: --           
d6        R: --           G: --           B: --           
d7        R: --           G: --           B: --           
d8  OUT1  R: 1b (Pal:1b)  G: 00 (Par:36)  B: 1b (Pal:1b)  
d9        R: --           G: --           B: --           
da        R: --           G: --           B: --           
db        R: --           G: --           B: --           
dc  OUT1  R: 1b (Pal:1b)  G: 00 (Par:37)  B: 1b (Pal:1b)  
dd        R: --           G: --           B: --           
de        R: --           G: --           B: --           
df        R: --           G: --           B: --           
e0  OUT1  R: 1c (Pal:1c)  G: 00 (Par:38)  B: 1c (Pal:1c)  
e1        R: --           G: --           B: --           
e2        R: --           G: --           B: --           
e3        R: --           G: --           B: --           
e4  OUT1  R: 1c (Pal:1c)  G: 00 (Par:39)  B: 1c (Pal:1c)  
e5        R: --           G: --           B: --           
e6        R: --           G: --           B: --           
e7        R: --           G: --           B: --           
e8  OUT1  R: 1d (Pal:1d)  G: 00 (Par:3a)  B: 1d (Pal:1d)  
e9        R: --           G: --           B: --           
ea        R: --           G: --           B: --           
eb        R: --           G: --           B: --           
ec  OUT1  R: 1d (Pal:1d)  G: 00 (Par:3b)  B: 1d (Pal:1d)  
ed        R: --           G: --           B: --           
ee        R: --           G: --           B: --           
ef        R: --           G: --           B: --           
f0  OUT1  R: 1e (Pal:1e)  G: 00 (Par:3c)  B: 1e (Pal:1e)  
f1        R: --           G: --           B: --           
f2        R: --           G: --           B: --           
f3        R: --           G: --           B: --           
f4  OUT1  R: 1e (Pal:1e)  G: 00 (Par:3d)  B: 1e (Pal:1e)  
f5        R: --           G: --           B: --           
f6        R: --           G: --           B: --           
f7        R: --           G: --           B: --           
f8  OUT1  R: 1f (Pal:1f)  G: 00 (Par:3e)  B: 1f (Pal:1f)  
f9        R: --           G: --           B: --           
fa        R: --           G: --           B: --           
fb        R: --           G: --           B: --           
fc  OUT1  R: 1f (Pal:1f)  G: 00 (Par:3f)  B: 1f (Pal:1f)  
fd        R: --           G: --           B: --           
fe        R: --           G: --           B: --           
ff        R: --           G: --           B: --           


Palette Dump:

00        R: 00 (Par:00)  G: 00 (Par:00)  B: 00 (Par:00)  
01        R: 01 (Par:01)  G: 01 (Par:01)  B: 01 (Par:01)  
02        R: 02 (Par:02)  G: 02 (Par:02)  B: 02 (Par:02)  
03        R: 03 (Par:03)  G: 03 (Par:03)  B: 03 (Par:03)  
04        R: 04 (Par:04)  G: 04 (Par:04)  B: 04 (Par:04)  
05        R: 05 (Par:05)  G: 05 (Par:05)  B: 05 (Par:05)  
06        R: 06 (Par:06)  G: 06 (Par:06)  B: 06 (Par:06)  
07        R: 07 (Par:07)  G: 07 (Par:07)  B: 07 (Par:07)  
08        R: 08 (Par:08)  G: 08 (Par:08)  B: 08 (Par:08)  
09        R: 09 (Par:09)  G: 09 (Par:09)  B: 09 (Par:09)  
0a        R: 0a (Par:0a)  G: 0a (Par:0a)  B: 0a (Par:0a)  
0b        R: 0b (Par:0b)  G: 0b (Par:0b)  B: 0b (Par:0b)  
0c        R: 0c (Par:0c)  G: 0c (Par:0c)  B: 0c (Par:0c)  
0d        R: 0d (Par:0d)  G: 0d (Par:0d)  B: 0d (Par:0d)  
0e        R: 0e (Par:0e)  G: 0e (Par:0e)  B: 0e (Par:0e)  
0f        R: 0f (Par:0f)  G: 0f (Par:0f)  B: 0f (Par:0f)  
10        R: 10 (Par:10)  G: 10 (Par:10)  B: 10 (Par:10)  
11        R: 11 (Par:11)  G: 11 (Par:11)  B: 11 (Par:11)  
12        R: 12 (Par:12)  G: 12 (Par:12)  B: 12 (Par:12)  
13        R: 13 (Par:13)  G: 13 (Par:13)  B: 13 (Par:13)  
14        R: 14 (Par:14)  G: 14 (Par:14)  B: 14 (Par:14)  
15        R: 15 (Par:15)  G: 15 (Par:15)  B: 15 (Par:15)  
16        R: 16 (Par:16)  G: 16 (Par:16)  B: 16 (Par:16)  
17        R: 17 (Par:17)  G: 17 (Par:17)  B: 17 (Par:17)  
18        R: 18 (Par:18)  G: 18 (Par:18)  B: 18 (Par:18)  
19        R: 19 (Par:19)  G: 19 (Par:19)  B: 19 (Par:19)  
1a        R: 1a (Par:1a)  G: 1a (Par:1a)  B: 1a (Par:1a)  
1b        R: 1b (Par:1b)  G: 1b (Par:1b)  B: 1b (Par:1b)  
1c        R: 1c (Par:1c)  G: 1c (Par:1c)  B: 1c (Par:1c)  
1d        R: 1d (Par:1d)  G: 1d (Par:1d)  B: 1d (Par:1d)  
1e        R: 1e (Par:1e)  G: 1e (Par:1e)  B: 1e (Par:1e)  
1f        R: 1f (Par:1f)  G: 1f (Par:1f)  B: 1f (Par:1f)  
20        R: 00 (Par:20)  G: 00 (Par:20)  B: 00 (Par:20)  
21        R: 00 (Par:21)  G: 00 (Par:21)  B: 00 (Par:21)  
22        R: 00 (Par:22)  G: 00 (Par:22)  B: 00 (Par:22)  
23        R: 00 (Par:23)  G: 00 (Par:23)  B: 00 (Par:23)  
24        R: 00 (Par:24)  G: 00 (Par:24)  B: 00 (Par:24)  
25        R: 00 (Par:25)  G: 00 (Par:25)  B: 00 (Par:25)  
26        R: 00 (Par:26)  G: 00 (Par:26)  B: 00 (Par:26)  
27        R: 00 (Par:27)  G: 00 (Par:27)  B: 00 (Par:27)  
28        R: 00 (Par:28)  G: 00 (Par:28)  B: 00 (Par:28)  
29        R: 00 (Par:29)  G: 00 (Par:29)  B: 00 (Par:29)  
2a        R: 00 (Par:2a)  G: 00 (Par:2a)  B: 00 (Par:2a)  
2b        R: 00 (Par:2b)  G: 00 (Par:2b)  B: 00 (Par:2b)  
2c        R: 00 (Par:2c)  G: 00 (Par:2c)  B: 00 (Par:2c)  
2d        R: 00 (Par:2d)  G: 00 (Par:2d)  B: 00 (Par:2d)  
2e        R: 00 (Par:2e)  G: 00 (Par:2e)  B: 00 (Par:2e)  
2f        R: 00 (Par:2f)  G: 00 (Par:2f)  B: 00 (Par:2f)  
30        R: 00 (Par:30)  G: 00 (Par:30)  B: 00 (Par:30)  
31        R: 00 (Par:31)  G: 00 (Par:31)  B: 00 (Par:31)  
32        R: 00 (Par:32)  G: 00 (Par:32)  B: 00 (Par:32)  
33        R: 00 (Par:33)  G: 00 (Par:33)  B: 00 (Par:33)  
34        R: 00 (Par:34)  G: 00 (Par:34)  B: 00 (Par:34)  
35        R: 00 (Par:35)  G: 00 (Par:35)  B: 00 (Par:35)  
36        R: 00 (Par:36)  G: 00 (Par:36)  B: 00 (Par:36)  
37        R: 00 (Par:37)  G: 00 (Par:37)  B: 00 (Par:37)  
38        R: 00 (Par:38)  G: 00 (Par:38)  B: 00 (Par:38)  
39        R: 00 (Par:39)  G: 00 (Par:39)  B: 00 (Par:39)  
3a        R: 00 (Par:3a)  G: 00 (Par:3a)  B: 00 (Par:3a)  
3b        R: 00 (Par:3b)  G: 00 (Par:3b)  B: 00 (Par:3b)  
3c        R: 00 (Par:3c)  G: 00 (Par:3c)  B: 00 (Par:3c)  
3d        R: 00 (Par:3d)  G: 00 (Par:3d)  B: 00 (Par:3d)  
3e        R: 00 (Par:3e)  G: 00 (Par:3e)  B: 00 (Par:3e)  
3f        R: 00 (Par:3f)  G: 00 (Par:3f)  B: 00 (Par:3f)  
40        R: --           G: --           B: --           
41        R: --           G: --           B: --           
42        R: --           G: --           B: --           
43        R: --           G: --           B: --           
44        R: --           G: --           B: --           
45        R: --           G: --           B: --           
46        R: --           G: --           B: --           
47        R: --           G: --           B: --           
48        R: --           G: --           B: --           
49        R: --           G: --           B: --           
4a        R: --           G: --           B: --           
4b        R: --           G: --           B: --           
4c        R: --           G: --           B: --           
4d        R: --           G: --           B: --           
4e        R: --           G: --           B: --           
4f        R: --           G: --           B: --           
50        R: --           G: --           B: --           
51        R: --           G: --           B: --           
52        R: --           G: --           B: --           
53        R: --           G: --           B: --           
54        R: --           G: --           B: --           
55        R: --           G: --           B: --           
56        R: --           G: --           B: --           
57        R: --           G: --           B: --           
58        R: --           G: --           B: --           
59        R: --           G: --           B: --           
5a        R: --           G: --           B: --           
5b        R: --           G: --           B: --           
5c        R: --           G: --           B: --           
5d        R: --           G: --           B: --           
5e        R: --           G: --           B: --           
5f        R: --           G: --           B: --           
60        R: --           G: --           B: --           
61        R: --           G: --           B: --           
62        R: --           G: --           B: --           
63        R: --           G: --           B: --           
64        R: --           G: --           B: --           
65        R: --           G: --           B: --           
66        R: --           G: --           B: --           
67        R: --           G: --           B: --           
68        R: --           G: --           B: --           
69        R: --           G: --           B: --           
6a        R: --           G: --           B: --           
6b        R: --           G: --           B: --           
6c        R: --           G: --           B: --           
6d        R: --           G: --           B: --           
6e        R: --           G: --           B: --           
6f        R: --           G: --           B: --           
70        R: --           G: --           B: --           
71        R: --           G: --           B: --           
72        R: --           G: --           B: --           
73        R: --           G: --           B: --           
74        R: --           G: --           B: --           
75        R: --           G: --           B: --           
76        R: --           G: --           B: --           
77        R: --           G: --           B: --           
78        R: --           G: --           B: --           
79        R: --           G: --           B: --           
7a        R: --           G: --           B: --           
7b        R: --           G: --           B: --           
7c        R: --           G: --           B: --           
7d        R: --           G: --           B: --           
7e        R: --           G: --           B: --           
7f        R: --           G: --           B: --           
80        R: --           G: --           B: --           
81        R: --           G: --           B: --           
82        R: --           G: --           B: --           
83        R: --           G: --           B: --           
84        R: --           G: --           B: --           
85        R: --           G: --           B: --           
86        R: --           G: --           B: --           
87        R: --           G: --           B: --           
88        R: --           G: --           B: --           
89        R: --           G: --           B: --           
8a        R: --           G: --           B: --           
8b        R: --           G: --           B: --           
8c        R: --           G: --           B: --           
8d        R: --           G: --           B: --           
8e        R: --           G: --           B: --           
8f        R: --           G: --           B: --           
90        R: --           G: --           B: --           
91        R: --           G: --           B: --           
92        R: --           G: --           B: --           
93        R: --           G: --           B: --           
94        R: --           G: --           B: --           
95        R: --           G: --           B: --           
96        R: --           G: --           B: --           
97        R: --           G: --           B: --           
98        R: --           G: --           B: --           
99        R: --           G: --           B: --           
9a        R: --           G: --           B: --           
9b        R: --           G: --           B: --           
9c        R: --           G: --           B: --           
9d        R: --           G: --           B: --           
9e        R: --           G: --           B: --           
9f        R: --           G: --           B: --           
a0        R: --           G: --           B: --           
a1        R: --           G: --           B: --           
a2        R: --           G: --           B: --           
a3        R: --           G: --           B: --           
a4        R: --           G: --           B: --           
a5        R: --           G: --           B: --           
a6        R: --           G: --           B: --           
a7        R: --           G: --           B: --           
a8        R: --           G: --           B: --           
a9        R: --           G: --           B: --           
aa        R: --           G: --           B: --           
ab        R: --           G: --           B: --           
ac        R: --           G: --           B: --           
ad        R: --           G: --           B: --           
ae        R: --           G: --           B: --           
af        R: --           G: --           B: --           
b0        R: --           G: --           B: --           
b1        R: --           G: --           B: --           
b2        R: --           G: --           B: --           
b3        R: --           G: --           B: --           
b4        R: --           G: --           B: --           
b5        R: --           G: --           B: --           
b6        R: --           G: --           B: --           
b7        R: --           G: --           B: --           
b8        R: --           G: --           B: --           
b9        R: --           G: --           B: --           
ba        R: --           G: --           B: --           
bb        R: --           G: --           B: --           
bc        R: --           G: --           B: --           
bd        R: --           G: --           B: --           
be        R: --           G: --           B: --           
bf        R: --           G: --           B: --           
c0        R: --           G: --           B: --           
c1        R: --           G: --           B: --           
c2        R: --           G: --           B: --           
c3        R: --           G: --           B: --           
c4        R: --           G: --           B: --           
c5        R: --           G: --           B: --           
c6        R: --           G: --           B: --           
c7        R: --           G: --           B: --           
c8        R: --           G: --           B: --           
c9        R: --           G: --           B: --           
ca        R: --           G: --           B: --           
cb        R: --           G: --           B: --           
cc        R: --           G: --           B: --           
cd        R: --           G: --           B: --           
ce        R: --           G: --           B: --           
cf        R: --           G: --           B: --           
d0        R: --           G: --           B: --           
d1        R: --           G: --           B: --           
d2        R: --           G: --           B: --           
d3        R: --           G: --           B: --           
d4        R: --           G: --           B: --           
d5        R: --           G: --           B: --           
d6        R: --           G: --           B: --           
d7        R: --           G: --           B: --           
d8        R: --           G: --           B: --           
d9        R: --           G: --           B: --           
da        R: --           G: --           B: --           
db        R: --           G: --           B: --           
dc        R: --           G: --           B: --           
dd        R: --           G: --           B: --           
de        R: --           G: --           B: --           
df        R: --           G: --           B: --           
e0        R: --           G: --           B: --           
e1        R: --           G: --           B: --           
e2        R: --           G: --           B: --           
e3        R: --           G: --           B: --           
e4        R: --           G: --           B: --           
e5        R: --           G: --           B: --           
e6        R: --           G: --           B: --           
e7        R: --           G: --           B: --           
e8        R: --           G: --           B: --           
e9        R: --           G: --           B: --           
ea        R: --           G: --           B: --           
eb        R: --           G: --           B: --           
ec        R: --           G: --           B: --           
ed        R: --           G: --           B: --           
ee        R: --           G: --           B: --           
ef        R: --           G: --           B: --           
f0        R: --           G: --           B: --           
f1        R: --           G: --           B: --           
f2        R: --           G: --           B: --           
f3        R: --           G: --           B: --           
f4        R: --           G: --           B: --           
f5        R: --           G: --           B: --           
f6        R: --           G: --           B: --           
f7        R: --           G: --           B: --           
f8        R: --           G: --           B: --           
f9        R: --           G: --           B: --           
fa        R: --           G: --           B: --           
fb        R: --           G: --           B: --           
fc        R: --           G: --           B: --           
fd        R: --           G: --           B: --           
fe        R: --           G: --           B: --           
ff        R: --           G: --           B: --           

--------------020507050705050905080002--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
