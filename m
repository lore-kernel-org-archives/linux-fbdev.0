From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 11 Jan 2011 18:17:56 +0000
Subject: Re: A query on frame buffers
Message-Id: <20110111181756.GI14017@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
	<20110107165813.GA24320@dumpdata.com>
	<AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
	<20110107192437.GD27871@dumpdata.com>
	<AANLkTim4Cm-3gWwpqa8YmPekoyariRXVrzB6Ayv-zHAi@mail.gmail.com>
	<20110110181716.GA9627@dumpdata.com>
	<AANLkTikRJvAeDB7JDx+5NrAt8Rct8AvTTY+9LoGTOaqy@mail.gmail.com>
	<20110110202451.GA14293@dumpdata.com>
	<AANLkTimJ=WwnCtUNzQcxwHgHZp_bqQwt8YfiXm=g0gv-@mail.gmail.com>
In-Reply-To: <AANLkTimJ=WwnCtUNzQcxwHgHZp_bqQwt8YfiXm=g0gv-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prasad Joshi <prasadjoshi124@gmail.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> > What motherboard is this?
> 
> ASUS M4A89TD Pro/USB3, it is mentioned on the link
> http://wiki.xensource.com/xenwiki/VTdHowTo

I am not sure how the implementation of the IOMMU
in the Xen hypervisor is different from the Linux implementation.
Usually it is lock-step, but it might be different.

Also, Xen's QEMU has different mechanism for handling PCI passthrough
so ... 

Lots of variables to figure out why it does not work for you.
It might make sense to start first with a working case and from there
start switching over to KVM.
