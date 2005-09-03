From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [-mm patch] FB_GEODE should depend on PCI
Date: Sat, 03 Sep 2005 18:49:31 +0100
Message-ID: <1125769771.14987.9.camel@localhost.localdomain>
References: <20050903120134.GL3657@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750941AbVICR1y@vger.kernel.org>
In-Reply-To: <20050903120134.GL3657@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: David Vrabel <dvrabel@arcom.com>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sad, 2005-09-03 at 14:01 +0200, Adrian Bunk wrote:
> Due to fbdev-geode-updates.patch, building with CONFIG_PCI=n results in 
> the following error:

All the Geodes have PCI or internal PCI emulation so that change makes
sense.
