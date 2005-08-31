From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 21:52:16 +0200
Message-ID: <43160A70.8020701@t-online.de>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home> <4315A6AB.5090108@t-online.de> <Pine.LNX.4.61.0508311750140.3728@scrub.home> <431602CC.1030008@t-online.de> <Pine.LNX.4.61.0508312125360.3743@scrub.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751015AbVHaTtY@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508312125360.3743@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>, Geert Uytterhoeven <geert@linux-m68k.org>


>>The special case for s_pitch == 2 saves about 270 ms system time (2120 ->
>>1850ms)
>>with a 16x30 font.
>>    
>>
>Compared to what? How much is the function call overhead?
>
>  
>
Your version of the inline code inserted after an if (idx==2) in 
bit_putcs against my version of the
inline code.

cu,
 knut
