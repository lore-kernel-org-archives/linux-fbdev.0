From: Ian Campbell <icampbell@arcom.com>
Subject: Re: [PATCH] PXA255 LCD Driver
Date: Wed, 17 Mar 2004 12:06:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1079525185.13373.143.camel@icampbell-debian>
References: <1079518182.13373.27.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
	 <1079521633.13370.39.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

> > I was trying too (I mostly copied the i810 driver). How wrong did I get
> > it? I'm willing to rework it to make it the same as the standard.
> 
> Take a look at drivers/video/modedb.c and fb_find_mode().

Ah, I had seen that, but it doesn't seem to be very appropriate for an
LCD controller in an embedded environment. TFT and STN (STN in
particular) displays don't often fit into any of the standard mode
definitions. There's also several settings which aren't in the DB, such
as pixel clock polarity, dual vs. single panel STN etc.

I quite often get asked to make some arbitrary panel which a customer
picked up somewhere dirt cheap to work, it is very useful to be able to
give each of the parameters explicitly, even if they do not correspond
to a mode listed in the DB. 

I could make the code use the same XRESxYRES-DEPTH syntax though since
the 2.4 version did (by copying the parsing code from fb_find_mode()), I
just changed it to match i810fb for the 2.6 port.

I had considered extending the modedb stuff to support the requirements
of embedded LCD controller drivers and to encompass a db of LCD panels
by part number (Kconfig selectable, something like the NLS support
perhaps) containing the extra options that you can have -- but I wasn't
sure if it was something that would be useful only to me or to all
embedded LCD driver authors.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been checked for all viruses by MessageLabs Virus Control Centre.
