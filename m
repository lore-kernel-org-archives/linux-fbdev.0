Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015415E8B;
	Fri, 20 Sep 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846283; cv=none; b=XesUBVRqWIR/geVMauebnfCiHGcDvXwgbHSDYgUyGFKNVif7OUyrloF7b10M35yBIT/3iWV4d0ROlpAmOfX6QfmxbqnnxP2wbtGmA4UHsn2fIU/adxC/P7cQcU/xKVdWt2YgUk98rL5WB+PlYpylhB54Z71ECZygwkGT4qetYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846283; c=relaxed/simple;
	bh=nb1fw4xOjw3VgH7BlEhgt2tmXoZj3fpRV2Bzr0yC4gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWRzBHA6vUc8grk8NOgq3c58pJnhAWGhRKxe/l2w+z7p5wRwBEZKrJ/Oay50N2bxC2zDAAi7dq+XVeyqdjG+dzcel1AKdwHllyH9d8t0gwPeTtC7lIwYjZqZ5aj1TeqZoJ5gFYwJ6rNRop+yylOoDBLyIA1Q7Ul0jbOtP4ma+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CwiO7nqJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CwiO7nqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ik0gK8vRwGiHfDmJUuUxNY6F8LkSlnZadKmBWuY90CI=;
	b=CwiO7nqJAb74PnXh6/KJFnbmieBdqJQDpsqaOxH7w/V9s1kgCTJoy/vT3qYrd4
	D5OGz+9sWPwh1vPly0BMmxyi4SPw7hhpAIqUdnxeOZHmHFeoOqB4I9D138l1RWti
	kipx8r9CiEryuXG2UqoC4irxhsgWKGDw0HdjFcFyrzoZg=
Received: from localhost (unknown [36.33.37.137])
	by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wAnb+oLle1meaO8EQ--.24619S2;
	Fri, 20 Sep 2024 23:30:19 +0800 (CST)
Date: Fri, 20 Sep 2024 23:30:18 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Helge Deller <deller@gmx.de>
Cc: aniel@ffwll.ch, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
	syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Subject: Re: [PATCH] fbcon: Fix a NULL pointer dereference issue in
 fbcon_putcs
Message-ID: <Zu2VCshU3Jx5X7oE@thinkpad.lan>
References: <20240916011027.303875-1-qianqiang.liu@163.com>
 <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
X-CM-TRANSID:_____wAnb+oLle1meaO8EQ--.24619S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1xKw1DWry8Kw4xXw45GFg_yoWfCFcEv3
	y7CFWYg3y7Xa43A3ZxWanxJFZF9w1UJF1UuryrZrnF9anxGr4UCan5XrWxJr4jgFZIqa10
	9F4UJFn7KFWF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0tCzJUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwxgambtjEK3EwAAsI

Hi, 

I simplified the C reproducer as follows:

#include <stdint.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <linux/tiocl.h>
#include <sys/ioctl.h>

struct param {
        uint8_t type;
        struct tiocl_selection ts;
};

int main()
{
        write(1, "executing program\n", sizeof("executing program\n") - 1);

        int fd = open("/dev/fb1", 0, 0);

        struct fb_con2fbmap con2fb;
        con2fb.console = 0x19;
        con2fb.framebuffer = 0;
        ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

        int fd1 = open("/dev/tty1", O_RDWR, 0);

        struct param param;
        param.type = 2;
        param.ts.xs = 0;
        param.ts.ys = 0;
        param.ts.xe = 0;
        param.ts.ye = 0;
        param.ts.sel_mode = 0;

        ioctl(fd1, TIOCLINUX, &param);

        con2fb.console = 1;
        con2fb.framebuffer = 0;
        ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

        return 0;
}

But I still need time to debug the kernel code..

-- 
Best,
Qianqiang Liu

