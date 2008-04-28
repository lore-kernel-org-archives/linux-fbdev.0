From: Dave Airlie <airlied@linux.ie>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets support ?
Date: Mon, 28 Apr 2008 20:18:34 +0100 (IST)
Message-ID: <alpine.DEB.0.82.0804282016440.5277@skynet.skynet.ie>
References: <4815EEB4.2060509@frugalware.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936671AbYD1TSt@vger.kernel.org>
In-Reply-To: <4815EEB4.2060509@frugalware.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriel C <crazy@frugalware.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Wang Zhenyu <zhenyu.z.wang@intel.com>

On Mon, 28 Apr 2008, Gabriel C wrote:

> Hello ,
> 
> are there any plans to add G33 / Q33 / Q35 chipsets support for the intelfb driver ?
> Is this driver still maintained ?
> 
> ( I'm not really sure who maintains this driver so I've add peoples to CC I saw worked on it ,
> I've also added Wang Zhenyu to CC while he added this support for AGP )
> 

Intel fb is unmaintained (well I've done trivial fixes in the past), and 
I'd rather not add new chipset support to it.

We are working (RH and Intel) on a new kernel modesetting layer which will 
allow fbs integrated with proper memory management and support all intel 
hw, 

The main problem with intelfb is it trips up the userspace X drivers a lot 
and generally break things..

Dave.
