From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 14 Nov 2017 19:48:09 +0000
Subject: Re: [PATCH 1/3] backlight: as3711_bl: fix device-tree node lookup
Message-Id: <ada29d80-4589-b419-cf9e-881bab227528@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171113102049.9342-1-johan@kernel.org>
 <94c3debe-17f6-9151-eefe-129f2bd1cfd4@linaro.org>
 <20171114180514.GA11226@localhost>
In-Reply-To: <20171114180514.GA11226@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On 14/11/17 18:05, Johan Hovold wrote:
> On Mon, Nov 13, 2017 at 02:16:09PM +0000, Daniel Thompson wrote:
>> On 13/11/17 10:20, Johan Hovold wrote:
>>> Fix child-node lookup during probe, which ended up searching the whole
>>> device tree depth-first starting at the parent rather than just matching
>>> on its children.
>>>
>>> To make things worse, the parent mfd node was also prematurely freed.
>>>
>>> Note that the nodes returned from the two calls to of_parse_phandle()
>>> are also leaking, but fixing that is a bit more involved as pointers to
>>> node fields are being stored for later use.
>>
>> Is using a devm_kstrdup() to remember the full_name sufficient so get
>> each of the FIXMEs cleaned up as well?
> 
> Yeah, that may be sufficient, but looking closer at this now, it seems
> the name pointers (su1_fb and su2_fb) are only used as booleans, and the
> fb_name pointer in struct as3711_bl_data is never used at all.
> 
> So cleaning that up somehow (e.g. and maybe even dropping non-dt
> probing) would also work.
> 
> But since this is a separate, and less critical issue, I think it needs
> to be done as a follow up to this one.

To be honest it was adding the separate and less critical FIXMEs into 
the patches that attracted my attention in the first place. ;-)


Daniel.
