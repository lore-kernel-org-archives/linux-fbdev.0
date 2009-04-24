From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [V5] Xilinx : Framebuffer Driver:
	Add PLB support and cleanup DCR
Date: Fri, 24 Apr 2009 13:01:58 +0200
Message-ID: <200904241301.59775.arnd@arndb.de>
References: <20090417205119.3D35660055@mail16-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8690615679748806815=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <arnd@arndb.de>) id 1LxJCq-0008Vo-14
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Apr 2009 11:04:32 +0000
Received: from moutng.kundenserver.de ([212.227.126.186])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LxJCn-0005yR-Cj for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 24 Apr 2009 11:04:31 +0000
In-Reply-To: <20090417205119.3D35660055@mail16-sin.bigfish.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linuxppc-dev@ozlabs.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Suneel <suneelg@xilinx.com>, grant.likely@secretlab.ca, jwboyer@linux.vnet.ibm.com, akonovalov@ru.mvista.com, John Linn <john.linn@xilinx.com>

--===============8690615679748806815==
Content-Type: multipart/alternative; boundary="Boundary-00=_nwZ8JJ0oEqOGvRk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_nwZ8JJ0oEqOGvRk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday 17 April 2009, John Linn wrote:
> Added support for the new xps tft controller. The new core
> has PLB interface support in addition to existing DCR interface.
> 
> Removed platform device support as both MicroBlaze and PowerPC
> use device tree.

I just said in another email thread that we would need a CONFIG_DCR
option that DCR using drivers should depend on, if it ever happened
outside of powerpc.

Well, apparently this happened earlier than I expected.

Converting the driver to use the generic DCR interface
makes it possible to use in any system that provides this
interface, including those that use a hard CPU core with xilinx_fb
on an FPGA, so it makes sense to just change the dependency
in Kconfig and provide CONFIG_DCR in microblaze (unconditionally)
as well as in powerpc instead of the existing CONFIG_PPC_DCR.

	Arnd <><

--Boundary-00=_nwZ8JJ0oEqOGvRk
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans Light'; font-size:8pt; font-weight:200; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Friday 17 April 2009, John Linn wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Added support for the new xps tft controller. The new core</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; has PLB interface support in addition to existing DCR interface.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Removed platform device support as both MicroBlaze and PowerPC</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; use device tree.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I just said in another email thread that we would need a CONFIG_DCR</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">option that DCR using drivers should depend on, if it ever happened</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">outside of powerpc.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Well, apparently this happened earlier than I expected.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Converting the driver to use the generic DCR interface</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">makes it possible to use in any system that provides this</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">interface, including those that use a hard CPU core with xilinx_fb</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">on an FPGA, so it makes sense to just change the dependency</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">in Kconfig and provide CONFIG_DCR in microblaze (unconditionally)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">as well as in powerpc instead of the existing CONFIG_PPC_DCR.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">	Arnd &lt;&gt;&lt;</p></body></html>
--Boundary-00=_nwZ8JJ0oEqOGvRk--


--===============8690615679748806815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============8690615679748806815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============8690615679748806815==--
