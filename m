From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: atyfb in 2.5.51
Date: 11 Dec 2002 21:35:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net> 
	<20021211.124347.127990341.davem@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021211.124347.127990341.davem@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@redhat.com>
Cc: jsimmons@infradead.org, benh@kernel.crashing.org, paulus@samba.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2002-12-11 at 20:43, David S. Miller wrote:
> fbdev is nice, in the specific cases where the device fits the fbdev
> model, because once you have the kernel bits you have X support :)

fbdev also can't be used in some situations on x86. Deeply fascinating
things happen on some x86 processors if you execute a loop of code with
an instruction that crosses two different memory types.
