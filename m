From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.5 fbdev & driver initial mode
Date: Thu, 9 Jan 2003 20:34:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301092025120.5660-100000@phoenix.infradead.org>
References: <1042108748.567.20.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1042108748.567.20.camel@zion.wanadoo.fr>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Note: on some platforms graphics chips with VGA cores are _not_ initialized to
> > VGA mode by the firmware. So great care should be taken when not explicitly
> > switching to graphics mode on those platforms.
> 
> Yup. This is typically the case of PowerMacs where the VGA memory isn't
> even reachable on the PCI/AGP bus. 

Here are the case we will have.

1) Embedded devices. People here have a tendency to want to use serial 
   console and just want fbdev without fbcon. Fbcon set the graphics state  
   in fbcon_startup. Now the developers want to know if the hardware 
   actually worked. So they can call fb_set_var and fb_show_logo 
   themselves in there drivers. They want to fully bring up the hardware.
  
2) Now say the above want to use fbcon. Then they don't need to set the 
   graphics state in there driver. Fbcon will do it for them. 

3) The graphics card has some kind of default text mode state. For the 
   case  where we want to use /dev/fb without fbcon and the text mode then
   we don't want to change the graphics state in the intialization code. 
   It is done in the first open and the last close.
