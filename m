From: Antonino Daplas <adaplas@pol.net>
Subject: Re: request_mem_region problem ...
Date: 02 Nov 2002 04:40:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036183227.622.13.camel@daplas>
References: <20021030130016.GA1573@iliana> <1036024416.644.23.camel@daplas>
	<20021031081007.GB617@iliana> <1036062270.638.25.camel@daplas>
	<20021101105242.GA702@iliana> <1036179467.572.42.camel@daplas>
	<20021101195207.GA931@iliana> <1036181217.572.5.camel@daplas> 
	<20021101202246.GA2026@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187icB-0002iD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 12:41:59 -0800
Received: from AP-202-70-99-40.compass.com.ph (AP-202-70-99-40.compass.com.ph [202.70.99.40])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id EAA76932
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 2 Nov 2002 04:41:56 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <20021101202246.GA2026@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-11-02 at 04:22, Sven Luther wrote:
[...]
> 
> > > Well, yes, i was going to donwload the BK tree, but james was speaking
> > > about a 2.5.45 diff, which was finally not the right one.
> > > 
> > I downloaded the patch 12 hours ago and actually ported a driver to
> > that.  So unless James changed it again, it should be the right one.
> 
> Mmm, yes, it was my fault.
> 
> BTW, is there something with the new kernel configuration process or
> something ? I get this error when trying to configure the kernel :
> 
> $ make oldconfig
> *
> * Unable to find the QT installation. Please make sure that the
> * QT development package is correctly installed and the QTDIR
> * environment variable is set to the correct location.
> *
> make[1]: *** [scripts/kconfig/.tmp_qtcheck] Erreur 1
> make: *** [scripts/kconfig/conf] Erreur 2
> 
> Is this something pulled in from james diff, or is it no more possible
> to configure the kernel with plain text console anymore ?
> 
It's an irritating bug in the new kernel configurator.  Try make -k if
it complains about the QT libs.



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
