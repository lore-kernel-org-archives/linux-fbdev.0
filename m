From: "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Date: Wed, 04 Mar 2020 01:31:20 +0000
Subject: Re: [PATCH] vgacon: Fix a UAF in vgacon_invert_region
Message-Id: <5c63d51f-b396-f2a7-a7c2-3b8af0bb54b0@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200303032036.40560-1-zhangxiaoxu5@huawei.com>
 <20200303135940.GS13686@intel.com>
 <67073029-8477-5f5a-ed2a-bb5ad4896878@huawei.com>
 <20200303144649.GT13686@intel.com>
In-Reply-To: <20200303144649.GT13686@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: akpm@osdl.org, pmladek@suse.com, wangkefeng.wang@huawei.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com



在 2020/3/3 22:46, Ville Syrjälä 写道:
> On Tue, Mar 03, 2020 at 10:30:14PM +0800, zhangxiaoxu (A) wrote:
>>
>>
>> 在 2020/3/3 21:59, Ville Syrjälä 写道:
>>> That doesn't match how vc_screenbuf_size is computed elsewhere. Also
>>> a lot of places seem to assume that the screenbuf can be larger than
>>> vga_vram_size (eg. all the memcpy()s pick the smaller size of the
>>> two).
>> Yes, in the vga source code, we also pick the smaller size of two. But
>> in other place, eg: vc_do_resize, copy the old_origin to new_origin, we
>> not do that. It also make bad access happen. it maybe CVE-2020-8647.
>>
>> I think we should just assume the width/height maybe larger than the
>> default, not the screenbuf larger than vga_vram_size.
>>
>> If not, any useful of the larger screenbuf?
> 
> Maybe used for scrolling?
The screenbuf just allocated with cols and rows, it can be save just one
screen?
vc_do_resize is the largest size which one screen can be shown?

If so, we can't set the screen to the resolution which more than it's
capability?
> 
>>
>>>
>>> And you're changing the behaviour of the code when
>>> 'width % 2 && user' is true
> 
