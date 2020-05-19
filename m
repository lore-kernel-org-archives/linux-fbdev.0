From: Sasha Levin <sashal@kernel.org>
Date: Tue, 19 May 2020 17:45:53 +0000
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-Id: <20200519174553.GF33628@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
 <20200519172105.GB1101627@kroah.com>
In-Reply-To: <20200519172105.GB1101627@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

On Tue, May 19, 2020 at 07:21:05PM +0200, Greg KH wrote:
>On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
>> +
>> +#define DXGK_MAX_LOCK_DEPTH	64
>> +#define W_MAX_PATH		260
>
>We already have a max path number, why use a different one?

It's max path for Windows, not Linux (thus the "W_" prefix) :)

Maybe changing it to WIN_MAX_PATH or such will make it better?

>> +#define d3dkmt_handle		u32
>> +#define d3dgpu_virtual_address	u64
>> +#define winwchar		u16
>> +#define winhandle		u64
>> +#define ntstatus		int
>> +#define winbool			u32
>> +#define d3dgpu_size_t		u64
>
>These are all ripe for a simple search/replace in your editor before you
>do your next version :)

I've actually attempted that, and reverted that change, mostly because
the whole 'handle' thing became very confusing.

Note that we have a few 'handles', each with a different size, and thus
calling get_something_something_handle() type of functions becase very
confusing since it's not clear what handle we're working with in that
case.

With regards to the rest, I wanted to leave stuff like 'winbool' to
document the expected ABI between the Windows and Linux side of things.
Ideally it would be 'bool' or 'u8', but as you see we had to use 'u32'
here which I feel lessens our ability to have the code document itself.

I don't feel too strongly against doing the conversion, and I won't
object to doing it if you do, but just be aware that I've tried it and
preferred to go back (even though our coding style doesn't like this) :)

-- 
Thanks,
Sasha
