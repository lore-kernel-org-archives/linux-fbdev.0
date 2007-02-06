From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Wed, 7 Feb 2007 00:08:26 +0100
Message-ID: <cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	 <20070128160831.fb51347f.akpm@osdl.org>
	 <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	 <20070128162907.370f5476.akpm@osdl.org>
	 <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	 <cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	 <20070130203301.GA15067@dreamland.darkstar.lan>
	 <20070204201713.GA12867@dreamland.darkstar.lan>
	 <Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030519AbXBFXI2@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Luca Tettamanti <kronos@people.it>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

On 2/6/07, James Simmons <jsimmons@infradead.org> wrote:
>
> If you can find post the manufacturer and model number we can place it on
> the backlist in fbmon. Also we should figure out what is wrong and fix it.

It's the UltraSharp UXGA display that used to come with Dell Inspiron
8200, 15" with a resolution of 1600x1200. I've been looking all around
for more info on it, but the only things I could find were posts that
remarked the problems Windows nVidia drivers have with some of these
(no image when running at 1600x1200), and other posts about banded
gradients with Windows drivers on Radeon video cards (but I get banded
gradients also win my nVidia card, on Linux, regardless of which
driver I use, binary, nv or nouveau).

As mentioned in another post in this thread, I can't get any info out
of the i2c busses, because even when I have them available (i.e. after
loading nvidiafb) I get XXXX all around (on all three of them).
Suggestions on how to get the information welcome.

-- 
Giuseppe "Oblomov" Bilotta
