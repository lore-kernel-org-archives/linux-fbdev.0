From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Linux-fbdev-devel] Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Mon, 27 Mar 2006 02:24:12 -0500
Message-ID: <D993BFD8-BB08-4128-93C4-E919817E3C42@mac.com>
References: <20060327004741.GA19187@MAIL.13thfloor.at> <1143422242.3589.2.camel@localhost.localdomain> <20060327033743.GA19788@MAIL.13thfloor.at> <1143437199.2221.3.camel@localhost.localdomain> <4427900C.7090506@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750719AbWC0HZA@vger.kernel.org>
In-Reply-To: <4427900C.7090506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Herbert Poetzl <herbert@13thfloor.at>, Linux Kernel ML <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Mar 27, 2006, at 02:11:08, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
>> On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:
>> Interesting... I suspect there is an endian bug in the new font  
>> code that hits odd sized fonts (or non-multiple-of-8 fonts). Can  
>> you try enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and  
>> tell me if those work ?
>>
>> Tony: If my suspition is confirmed, I think that's your call :)
>
> It probably is, a remnant of the console rotation code.  If that is  
> truly the case, the patch I just sent in another thread should fix it.

I ran into this same bug on my Dual 1GHz Windtunnel G4 with an  
upgraded GPU (Radeon 9800) in the 2.6.16-rc4 timeframe.  Turning off  
the customized console font selection and reverting to the default  
list of fonts fixed the problem for me.  I think I had the console  
rotation config option turned on, but I don't have that config any  
more and can't be sure.

Cheers,
Kyle Moffett
