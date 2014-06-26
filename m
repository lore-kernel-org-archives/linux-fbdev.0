From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 26 Jun 2014 20:32:42 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <EE124450C0AAF944A40DD71E61F878C98402B1@SINEX14MBXC418.southpacific.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403569757-2622-1-git-send-email-decui@microsoft.com>
 <20140624135101.GB10115@kroah.com>
 <EE124450C0AAF944A40DD71E61F878C98353C6@SINEX14MBXC418.southpacific.corp.microsoft.com>
 <20140626033608.GA32654@kroah.com>
In-Reply-To: <20140626033608.GA32654@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Haiyang Zhang <haiyangz@microsoft.com>

> > >> MS-TFS: 157532
> >
> > > What is this line for?
> >
> > Hi Greg,
> > This line is for our internal bug repository.
> > We have an automated system to correlate bugs with fixes so that our test
> > team knows when a bug fix has been accepted upstream and they need to
> > write a new test case for it.
> >
> > The MS-TFS line has appeared in the commit description for a while if you
> > search for it in 'git log'  of linux-next.
> >
> > Please let us know if you have further comments.
> 
> Please don't add marker lines like this that provide no relevancy to
> anyone else.  I don't allow gerrit ids for the same reason.  If you want
> to refer to a public bug tracker, that's great, otherwise, don't
> include it.
> 
> greg k-h

Ok, I'll remove the line and re-submit a v2 patch(the patch itself will be
the same).

Thanks,
-- Dexuan
