From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] video: add PXA3xx accelerator ID [v2]
Date: Thu, 10 Sep 2009 15:33:27 +0200
Message-ID: <20090910133327.GA9410@buzzloop.caiaq.de>
References: <20090910132630.GZ9410@buzzloop.caiaq.de>
	<Pine.LNX.4.64.0909101530120.4458@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909101530120.4458@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Sven Neumann <s.neumann@raumfeld.com>, linux-fbdev-devel@lists.sourceforge.net, Eric Miao <eric.y.miao@gmail.com>, Dennis Oliver Kropp <dok@directfb.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 10, 2009 at 03:31:34PM +0200, Guennadi Liakhovetski wrote:
> > +	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
> > +		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
> > +
> 
> Ok, now remove 'cpu_is_pxa3xx() && ' above and you should be good to go:-) 
> What if tomorrow pxa4xx comes (ok, Eric will disagree, but wtill:-))

Don't know. I left it in there intentionally, but I'm fine to remove it.
Or Eric does it when applying ;) Eric?

Daniel
