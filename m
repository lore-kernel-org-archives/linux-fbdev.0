From: "David S. Miller" <davem@redhat.com>
Subject: Re: atyfb in 2.5.51
Date: Wed, 11 Dec 2002 12:43:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021211.124347.127990341.davem@redhat.com>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: Text/Plain; charset="us-ascii"
To: jsimmons@infradead.org
Cc: benh@kernel.crashing.org, paulus@samba.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

   From: James Simmons <jsimmons@infradead.org>
   Date: Wed, 11 Dec 2002 07:16:04 -0800 (PST)
   
   I agree that the design of the /dev/fbX interface is not the best.
   Unfortunely we are stuck with it. Changing it would break userland apps.
   
I totally understand.  I do not suggest to break fbdev in it's current
form, too much stuff uses it.

My main point was, don't be surprised the X servers, like the ATI
driver, don't use fbdev and instead just mmap the device and simply
program it directly.

fbdev is nice, in the specific cases where the device fits the fbdev
model, because once you have the kernel bits you have X support :)

Franks a lot,
David S. Miller
davem@redhat.com
