From: Sebastian Frias <sf84@laposte.net>
Date: Tue, 29 Dec 2015 16:51:23 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <5682BA0B.9060001@laposte.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net>	<CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>	<5682936E.2040904@laposte.net> <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com>
In-Reply-To: <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Klaver <fransklaver@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

On 12/29/2015 03:16 PM, Frans Klaver wrote:
> On Tue, Dec 29, 2015 at 3:06 PM, Sebastian Frias <sf84@laposte.net> wrote:
>> Right now we don't know if the driver will be upstreamed.
>> Let me rephrase my question:
>>
>> - how would you recommend enabling FB_CFB_FILLRECT, FB_CFB_COPYAREA and
>> FB_CFB_IMAGEBLIT for a driver that is not included in the kernel's tree?
>>
>> If that is not possible, I guess we will have to keep a forked tree until
>> the driver is upstreamed, but we would like to avoid that, hence the
>> question.
>
> I guess you'll have to keep on doing that indeed. I'm not aware of any
> location where out-of-tree drivers are considered. You should try
> again when you have some actual code to upstream.
>

Ok, thanks.
