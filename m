From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [patch 17/18] PS3: Frame buffer system-bus
	rework
Date: Wed, 06 Jun 2007 23:56:58 +0800
Message-ID: <1181145418.5023.11.camel@daplas>
References: <20070606024407.786638029@am.sony.com> >
	<46662399.7030401@am.sony.com>
	<Pine.LNX.4.62.0706060849530.19499@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <Pine.LNX.4.62.0706060849530.19499@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>

On Wed, 2007-06-06 at 08:51 +0200, Geert Uytterhoeven wrote:
> This one should go through linux-fbdev-devel (CC) for review, but Paul can
> merge it because it depends on the PS3 system bus device rework.
> 

> >  
> > -static void ps3fb_shutdown(struct platform_device *dev)
> > +static int __devexit ps3fb_remove(struct ps3_system_bus_device *dev)
> >  {
> > -	ps3fb_flip_ctl(0);	/* flip off */
> > -	ps3fb.dinfo->irq.mask = 0;
> > -	free_irq(ps3fb.irq_no, ps3fb.dev);
> > -	ps3_irq_plug_destroy(ps3fb.irq_no);
> > -	iounmap((u8 __iomem *)ps3fb.dinfo);
> > +	BUG();

Why BUG()?

Tony
