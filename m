Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5C426D15;
	Fri, 27 Feb 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204028; cv=none; b=hmC3G5gbt8S3YSxSy2eY8F8iVqLfln8UgC7ogpKS+AQ399eIDq5HPIBTtH36rWrupMZIR4iJi7oypi52gR2/EA4t8EAj4fz48TnyizUEdk3VfLse17YDdBG2EBMR87S4/4Mt6ZoW6VyzT5YASQVnLlLy7Bsr2hSpQJwi9YfSq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204028; c=relaxed/simple;
	bh=xmdpq2mQZhM0+XlR0mk15ZrNpMS+GT6/9EjK9t7N6mo=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=IOkhrVUk0zTyukQ6m4PAkDIMP2QGPh87LHPqjXaUQZGs/2l0Cl3Bmi2D8ybryab5G1uCz/WaApMUL62LzEptD4aHFcjc+TP1YUtJXx5fHEPm3fSkFQl+aPneLdojDsJre8rmh+NNx/h/klPDID6iSb8uUnqQGnFdPGpLgr0Ku0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hUo0hPNq; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hUo0hPNq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rjc0I2sq+8V68odW29mgk/sqTyFId3HHdwyMQagY59g=;
	b=hUo0hPNqzB2mJeoek1NHLSswLjKXtH1o0KEQ8h4+G5cvVK/qw5ItkxJq7W9RCquUZMkg+GdL4
	oX/D0LPXBgm/O0dUw7ezxMiak5Rgf7QvmCmExPuFTum/xRbJYgmcbQodx1Bve3BoT76Dyuxm/Gw
	+WoTApBEwHndPmNIkjriJ08=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fMrn12jpgzmVVb;
	Fri, 27 Feb 2026 22:48:53 +0800 (CST)
Received: from dggpemf200010.china.huawei.com (unknown [7.185.36.144])
	by mail.maildlp.com (Postfix) with ESMTPS id 86F7C40565;
	Fri, 27 Feb 2026 22:53:42 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (7.185.36.138) by
 dggpemf200010.china.huawei.com (7.185.36.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 22:53:42 +0800
Received: from dggpemf100008.china.huawei.com ([7.185.36.138]) by
 dggpemf100008.china.huawei.com ([7.185.36.138]) with mapi id 15.02.1544.011;
 Fri, 27 Feb 2026 22:53:42 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: "simona@ffwll.ch" <simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linruifeng (A)" <linruifeng4@huawei.com>
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Topic: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
Thread-Index: AQHcp/hkWokbZ7kj9E6ZoDdZSs/a8A==
Date: Fri, 27 Feb 2026 14:53:42 +0000
Message-ID: <e300c23760df488aaaa0648c4593c802@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=1B$B:_=1B(B 2026/2/27 22:50, chenjun (AM) =1B$B<LF;=1B(B:=0A=
> When a font is set on an invisible console, the screen will not update.=
=0A=
> However, the fontbuffer is not updated to match the new font dimensions.=
=0A=
> =0A=
> This inconsistency leads to out-of-bounds memory access when writing to=
=0A=
> the tty bound to fbcon, as demonstrated by the following KASAN report:=0A=
> =0A=
> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140=0A=
> Read of size 1 at addr ffff8881195a2280 by task a.out/971=0A=
> Call Trace:=0A=
>   <TASK>=0A=
>   fb_pad_aligned_buffer+0xdf/0x140=0A=
>   ud_putcs+0x88a/0xde0=0A=
>   fbcon_putcs+0x319/0x430=0A=
>   do_update_region+0x23c/0x3b0=0A=
>   do_con_write+0x225c/0x67f0=0A=
>   con_write+0xe/0x30=0A=
>   n_tty_write+0x4b5/0xff0=0A=
>   file_tty_write.isra.41+0x46c/0x880=0A=
>   vfs_write+0x868/0xd60=0A=
>   ksys_write+0xf2/0x1d0=0A=
>   do_syscall_64+0xfa/0x570=0A=
> =0A=
> Fix this by calling fbcon_rotate_font() if vc is invisible in=0A=
> fbcon_do_set_font().=0A=
> =0A=
> Signed-off-by: Chen Jun <chenjun102@huawei.com>=0A=
> ---=0A=
>   drivers/video/fbdev/core/fbcon.c | 5 +++++=0A=
>   1 file changed, 5 insertions(+)=0A=
> =0A=
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c=0A=
> index 666261ae59d8..d76100188bee 100644=0A=
> --- a/drivers/video/fbdev/core/fbcon.c=0A=
> +++ b/drivers/video/fbdev/core/fbcon.c=0A=
> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,=0A=
>   		rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);=0A=
>   		cols /=3D w;=0A=
>   		rows /=3D h;=0A=
> +		if (!con_is_visible(vc)) {=0A=
> +			ret =3D fbcon_rotate_font(info, vc);=0A=
> +			if (ret)=0A=
> +				goto err_out;=0A=
> +		}=0A=
>   		ret =3D vc_resize(vc, cols, rows);=0A=
>   		if (ret)=0A=
>   			goto err_out;=0A=
> =0A=
=0A=
There is a poc:=0A=
```=0A=
#define _GNU_SOURCE=0A=
=0A=
#include <errno.h>=0A=
#include <fcntl.h>=0A=
#include <stdlib.h>=0A=
#include <unistd.h>=0A=
#include <stdint.h>=0A=
#include <sys/ioctl.h>=0A=
=0A=
#include <linux/capability.h>=0A=
=0A=
char my_font_data[512 * 1 * 32 * 32];=0A=
=0A=
struct console_font_op {=0A=
         unsigned int op;=0A=
         unsigned int flags;=0A=
         unsigned int width, height;=0A=
         unsigned int charcount;=0A=
         unsigned char *data;=0A=
};=0A=
=0A=
void execute_one(void)=0A=
{=0A=
   int tty =3D open("/dev/tty2", O_APPEND|O_RDWR, 0);=0A=
   char buf[100] =3D {27, '#', '8', 0xa, 0x5, 0x5, 0x5, 0x5};=0A=
   struct console_font_op op =3D {=0A=
         .op =3D 0,=0A=
         .width =3D 32,=0A=
         .height =3D 32,=0A=
         .charcount =3D 512,=0A=
         .data =3D my_font_data,=0A=
   };=0A=
=0A=
   ioctl(tty, 0x4B72, &op);=0A=
   write(tty, buf, 100);=0A=
}=0A=
int main(void)=0A=
{=0A=
   execute_one();=0A=
   return 0;=0A=
}=0A=
```=0A=
echo 2 > /sys/class/graphics/fbcon/rotate_all=0A=
./poc=0A=
