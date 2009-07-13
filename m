From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Mon, 13 Jul 2009 09:35:30 -0700
Message-ID: <20090713163530.GA22251@suse.de>
References: <20090713151709.GA1297@lilem.mirepesht>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752587AbZGMQis@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090713151709.GA1297@lilem.mirepesht>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ali Gholami Rudi <ali@rudi.ir>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

On Mon, Jul 13, 2009 at 07:47:09PM +0430, Ali Gholami Rudi wrote:
> Hi,
> 
> Is there any reason for not adding these ioctls to fbdev?  I searched
> the net and couldn't any.  Anyway, these patches simply implement those
> ioctls.

Have you also added the needed 32 vs. 64 bit handlers for these ioctls?

thanks,

greg k-h
