From: Rob Herring <robh@kernel.org>
Date: Tue, 01 Aug 2017 17:24:53 +0000
Subject: Re: [PATCH] video: fbdev: Convert to using %pOF instead of full_name
Message-Id: <CAL_JsqLy44aZdGcH7mGbmfQ49DTXU7fwoed8UCuaNEMVc_M8FQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170718214516epcas5p41593e7a72c2abb4ab7f78934027679fb@epcas5p4.samsung.com>
 <20170718214339.7774-56-robh@kernel.org> <4331639.hUALxSEUjp@amdc3058>
In-Reply-To: <4331639.hUALxSEUjp@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Aug 1, 2017 at 8:47 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, July 18, 2017 04:43:36 PM Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: linux-fbdev@vger.kernel.org
>
> The patch Looks fine to me. Do you want me to merge it through fbdev
> tree or do you have some other plan for %pOF conversion patches?

Please take thru the fbdev tree.

Rob
