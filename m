From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: fbdev sysfs support.
Date: Sat, 7 Feb 2004 01:10:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207011047.GR21151@parcelfarce.linux.theplanet.co.uk>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> +static void release_fb_info(struct class_device *class_dev)
> +{
> +	struct fb_info *info = to_fb_info(class_dev);
> +
> +	/* This doesn't harm */
> +	fb_dealloc_cmap(&info->cmap);
> +
> +	kfree(info);
> +}

So what has happens when we hit existing kfree() on fb_info while sysfs
node is busy?
