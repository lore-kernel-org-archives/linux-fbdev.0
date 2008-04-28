From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets support ?
Date: Sun, 27 Apr 2008 22:47:24 -0700
Message-ID: <20080427224724.18c11b94@infradead.org>
References: <4815EEB4.2060509@frugalware.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760859AbYD2NAO@vger.kernel.org>
In-Reply-To: <4815EEB4.2060509@frugalware.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Gabriel C <crazy@frugalware.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>, Wang Zhenyu <zhenyu.z.wang@intel.com>

On Mon, 28 Apr 2008 17:35:16 +0200
Gabriel C <crazy@frugalware.org> wrote:

> Hello ,
> 
> are there any plans to add G33 / Q33 / Q35 chipsets support for the
> intelfb driver ? Is this driver still maintained ?
> 
> ( I'm not really sure who maintains this driver so I've add peoples
> to CC I saw worked on it , I've also added Wang Zhenyu to CC while he
> added this support for AGP )
> 
> 

the real answer is to not use intelfb, at least not until the modesetting work lands in the kernel.
(and after that... do you really need it?)
