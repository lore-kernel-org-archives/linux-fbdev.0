From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 01/29] move acornfb's probe function to .devinit.text
Date: Sun, 24 Jan 2010 01:28:13 +0200
Message-ID: <20100123232813.GB4146@x200>
References: <1264189758-7197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1264278937-19675-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753004Ab0AWX2O@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1264278937-19675-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

On Sat, Jan 23, 2010 at 09:35:09PM +0100, Uwe Kleine-K=F6nig wrote:
> -static int __init acornfb_probe(struct platform_device *dev)
> +static int __devinit acornfb_probe(struct platform_device *dev)

Even more, if this function is marked __devinit, some other functions
can very well be marked __devinit, can you do this?
