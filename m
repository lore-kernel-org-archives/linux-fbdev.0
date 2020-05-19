From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2020 17:21:05 +0000
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-Id: <20200519172105.GB1101627@kroah.com>
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
> +
> +#define DXGK_MAX_LOCK_DEPTH	64
> +#define W_MAX_PATH		260

We already have a max path number, why use a different one?

> +#define d3dkmt_handle		u32
> +#define d3dgpu_virtual_address	u64
> +#define winwchar		u16
> +#define winhandle		u64
> +#define ntstatus		int
> +#define winbool			u32
> +#define d3dgpu_size_t		u64

These are all ripe for a simple search/replace in your editor before you
do your next version :)

thanks,

greg k-h
