From: Kronos <kronos@people.it>
Subject: Re: kbuild
Date: Fri, 24 Sep 2004 19:03:15 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040924170315.GA11905@dreamland.darkstar.lan>
References: <4152FE4A.732A42BB@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAtTb-0006er-VY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Sep 2004 10:03:19 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CAtTY-0004wE-QJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Sep 2004 10:03:19 -0700
Received: from dreamland.darkstar.lan (82.84.183.132) by mail-relay-3.tiscali.it (7.1.021.3)
        id 4111154D00C25323 for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Sep 2004 19:03:06 +0200
Content-Disposition: inline
In-Reply-To: <4152FE4A.732A42BB@orpatec.ch>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Il Thu, Sep 23, 2004 at 06:48:10PM +0200, Otto Wyss ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> IMO kbuild makes it easy to test new framebuffer drivers by anyone. So
> I've started to document the tester's part on the web
> "http://linux-fvdev.sourceforge.net/index.php?page=kbuilddocs.html". Now
> it would be nice if someone could create a correct Makefile for a
> framebuffer (preferable radeonfb) and send it to me, so I can put it
> into the linux-fbdev CVS.

It's very simple, a skeleton would be like that:

obj-m += myfb.o

If the object is composed by 2 or more files:

obj-m += myfb.o
myfb-objs := file1.o file2.o file3.o

Note that this will build a module regardless of what the user has in his
.config file. For drivers that has suboptions (like I2C bus for
radeonfb) you can either:
- rely on the .config from user. In this case you can just copy and
  adapt a bit the Makefile from the kernel tree. For radeonfb:

obj-m += radeonfb.o

radeonfb-y                              := radeon_base.o radeon_pm.o radeon_monitor.o radeon_accel.o
radeonfb-$(CONFIG_FB_RADEON_I2C)        += radeon_i2c.o
radeonfb-objs                           := $(radeonfb-y)

- force some options. In this case you may have to define some symbols
  manualy. Like this:

obj-m += radeonfb.o

# Force CONFIG_FB_RADEON_I2C
EXTRA_CFLAGS := -DCONFIG_FB_RADEON_I2C

radeonfb-objs   := radeon_base.o radeon_pm.o radeon_monitor.o radeon_accel.o radeon_i2c.o

Also note that some driver may need some header not present in the build
directory nor in the the standard include path. radeonfb, for example,
include "../edid.h".

HTH,
Luca
-- 
Home: http://kronoz.cjb.net
Se il  destino di un uomo  e` annegare, anneghera` anche  in un bicchier
d'acqua.
Proverbio yddish


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
