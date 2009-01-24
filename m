From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Sat, 24 Jan 2009 16:49:45 +0200
Message-ID: <46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <Pine.LNX.4.64.0901240951110.13803@anakin>
	 <46e1c7760901240109m5a0f3a85p788aa3ce35b49fa9@mail.gmail.com>
	 <Pine.LNX.4.64.0901241425310.13803@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757925AbZAXOt5@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0901241425310.13803@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

2009/1/24 Geert Uytterhoeven <geert@linux-m68k.org>:
>
> FYI, I've just seen the other patch you posted before.
> I'm also wondering what's really going wrong, as I haven't ever noticed this
> problem during the last 10 years.
>
Looks like the problem is connected to using HW-cursor, and not so
many framebuffer drivers do that, I've seen this only on atyfb.

Risto
