From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2020 17:19:06 +0000
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-Id: <20200519171906.GA1101627@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
> +/*
> + * Dxgkrnl Graphics Port Driver ioctl definitions
> + *
> + */
> +
> +#define LX_IOCTL_DIR_WRITE 0x1
> +#define LX_IOCTL_DIR_READ  0x2
> +
> +#define LX_IOCTL_DIR(_ioctl)	(((_ioctl) >> 30) & 0x3)
> +#define LX_IOCTL_SIZE(_ioctl)	(((_ioctl) >> 16) & 0x3FFF)
> +#define LX_IOCTL_TYPE(_ioctl)	(((_ioctl) >> 8) & 0xFF)
> +#define LX_IOCTL_CODE(_ioctl)	(((_ioctl) >> 0) & 0xFF)

Why create new ioctl macros, can't the "normal" kernel macros work
properly?

> +#define LX_IOCTL(_dir, _size, _type, _code) (	\
> +	(((uint)(_dir) & 0x3) << 30) |		\
> +	(((uint)(_size) & 0x3FFF) << 16) |	\
> +	(((uint)(_type) & 0xFF) << 8) |		\
> +	(((uint)(_code) & 0xFF) << 0))
> +
> +#define LX_IO(_type, _code) LX_IOCTL(0, 0, (_type), (_code))
> +#define LX_IOR(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_READ, (_size), (_type), (_code))
> +#define LX_IOW(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_WRITE, (_size), (_type), (_code))
> +#define LX_IOWR(_type, _code, _size)	\
> +	LX_IOCTL(LX_IOCTL_DIR_WRITE |	\
> +	LX_IOCTL_DIR_READ, (_size), (_type), (_code))
> +
> +#define LX_DXOPENADAPTERFROMLUID	\
> +	LX_IOWR(0x47, 0x01, sizeof(struct d3dkmt_openadapterfromluid))

<snip>

These structures do not seem to be all using the correct types for a
"real" ioctl in the kernel, so you will have to fix them all up before
this will work properly.

> +void ioctl_desc_init(void);

Very odd global name you are using here :)

Anyway, neat stuff, glad to see it posted, great work!

greg k-h
