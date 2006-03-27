From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: funny framebuffer fonts on PowerBook
 with radeonfb
Date: Mon, 27 Mar 2006 15:11:08 +0800
Message-ID: <4427900C.7090506@gmail.com>
References: <20060327004741.GA19187@MAIL.13thfloor.at>	 <1143422242.3589.2.camel@localhost.localdomain>	 <20060327033743.GA19788@MAIL.13thfloor.at> <1143437199.2221.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750758AbWC0HLZ@vger.kernel.org>
In-Reply-To: <1143437199.2221.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Herbert Poetzl <herbert@13thfloor.at>, Linux Kernel ML <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

Benjamin Herrenschmidt wrote:
> On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:
> Interesting... I suspect there is an endian bug in the new font code
> that hits odd sized fonts (or non-multiple-of-8 fonts). Can you try
> enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and tell me if
> those work ?
> 
> Tony: If my suspition is confirmed, I think that's your call :)

It probably is, a remnant of the console rotation code.  If that is
truly the case, the patch I just sent in another thread should fix it.

Tony
