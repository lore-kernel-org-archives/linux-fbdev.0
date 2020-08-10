From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 10 Aug 2020 09:56:13 +0000
Subject: Re: [PATCH v1 01/12] fbdev: gxfb: use generic power management
Message-Id: <20200810094413.GA7579@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
 <20200805180722.244008-2-vaibhavgupta40@gmail.com>
 <20200808111746.GA24172@ravnborg.org>
 <20200810093948.GB6615@gmail.com>
In-Reply-To: <20200810093948.GB6615@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn@helgaas.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-arm-kernel@lists.infradead.org, Andres Salomon <dilinger@queued.net>, Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>, linux-kernel-mentees@lists.linuxfoundation.org, linux-geode@lists.infradead.org

> > > -static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +static int __maybe_unused gxfb_suspend(struct device *dev)
> > >  {
> > > -	struct fb_info *info = pci_get_drvdata(pdev);
> > > +	struct fb_info *info = dev_get_drvdata(dev);
> > I do not see any dev_set_drvdata() so I guess we get a NULL pointer
> > here which is not intended.
> > Adding a dev_set_data() to gxfb_probe() would do the trick.
> > 
> gxfb_probe() invokes pci_set_drvdata(pdev, info) which in turn calls
> dev_set_drvdata(&pdev->dev, data). Adding dev_get_drvdata() will be redundant.
> 
s/dev_get_drvdata/dev_set_drvdata

Thanks
Vaibhav Gupta
