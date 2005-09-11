From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: -git10 undefined reference to `i2c_bit_add_bus'
Date: Sun, 11 Sep 2005 08:54:34 +0800
Message-ID: <4323804A.3090509@gmail.com>
References: <432313E3.9030208@ppp0.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEG8E-0003Ni-6X
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Sep 2005 17:55:42 -0700
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEG8D-0005x1-6A
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Sep 2005 17:55:42 -0700
Received: by zproxy.gmail.com with SMTP id 9so1483581nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Sep 2005 17:55:35 -0700 (PDT)
In-Reply-To: <432313E3.9030208@ppp0.net>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jan Dittmer wrote:
> I didn't look into details, but attached config does not
> compile anymore after selecting the new (compared to
> 2.6.13-rc6-git5) option CONFIG_FB_I810_I2C.
> 
> 
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `i810_setup_i2c_bus':
> i810-i2c.c:(.text+0x657d2): undefined reference to `i2c_bit_add_bus'
> drivers/built-in.o: In function `i810_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o: In function `i810_delete_i2c_busses':
> : undefined reference to `i2c_bit_del_bus'
> drivers/built-in.o: In function `i810_do_probe_i2c_edid':
> i810-i2c.c:(.text+0x6599b): undefined reference to `i2c_transfer'
> make: *** [.tmp_vmlinux1] Error 1
> 

Try the attached patch.  Run your make *config again, then recompile.

Fix compile error if CONFIG_FB_I810_I2C is 'y' and CONFIG_I2C = 'm'.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -708,7 +708,8 @@ config FB_I810_GTF
 
 config FB_I810_I2C
 	bool "Enable DDC Support"
-	depends on FB_I810 && I2C && FB_I810_GTF
+	depends on FB_I810 && FB_I810_GTF
+	select I2C
 	select I2C_ALGOBIT
 	help
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
