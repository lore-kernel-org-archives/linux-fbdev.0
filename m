From: Greg KH <greg@kroah.com>
Subject: Re: fbdev sysfs support.
Date: Fri, 6 Feb 2004 17:23:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040207012313.GF4492@kroah.com>
References: <20040207005954.GB4492@kroah.com> <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070100420.19559-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Feb 07, 2004 at 01:01:35AM +0000, James Simmons wrote:
> +static ssize_t show_dev(struct class_device *class_dev, char *buf)
> +{
> +	struct fb_info *info = to_fb_info(class_dev);
> +
> +	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
> +}

Another ick.  Please use the already present function for this,
print_dev_t().

thanks,

greg k-h
