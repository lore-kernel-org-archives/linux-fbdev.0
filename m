From: David Airlie <airlied@redhat.com>
Date: Thu, 27 Jun 2013 05:14:45 +0000
Subject: Re: [PATCH linux-next] fb: make fp_get_options name argument const
Message-Id: <1927037966.2377585.1372310085417.JavaMail.root@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371565386-23335-1-git-send-email-vincent.stehle@freescale.com> <51CAEAD5.40601@ti.com>
In-Reply-To: <51CAEAD5.40601@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@freescale.com>, linux-next@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, trivial@kernel.org

> > 
> > 
> > Hi,
> > 
> > I remarked this warning while building linux-next with imx_v6_v7_defconfig.
> > Is changing fb_get_options prototype "permitted", please?
> 
> I don't see how changing the parameter to const could break anything, so
> I've applied this to fbdev-3.11 branch.
> 

Hi Tomi,

What tree does Jean-Christophe PLAGNIOL-VILLARD control?

he said he merged the original patch to fix this from Ville, but I've no idea
where it ended up, so I just didn't merge it to drm-next at the time.

Message-Id: <1370619787-15341-3-git-send-email-ville.syrjala@linux.intel.com>

is the original properly attributed fix.

Dave.
