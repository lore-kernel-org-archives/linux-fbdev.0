From: Liu Ying <liu.y.victor@gmail.com>
Date: Fri, 03 Apr 2015 03:39:27 +0000
Subject: Re: [PATCH v2] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <CA+8Hj82+qWJxGFSevHwAqTb36DgRQ22OByywbdWjPh4j45Q6yw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425452771-19313-1-git-send-email-Ying.Liu@freescale.com>
	<54FEDD5D.4000104@ti.com>
	<20150311030327.GA3724@victor>
	<550C03D3.7090504@ti.com>
In-Reply-To: <550C03D3.7090504@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Liu Ying <Ying.Liu@freescale.com>, linux-fbdev@vger.kernel.org, Peter Chen <peter.chen@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

2015-03-20 19:26 GMT+08:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On 11/03/15 05:03, Liu Ying wrote:
>
>>> Why do you check for host->enabled here, but not elsewhere?
>>
>> We need this check here to make sure the axi clock reference count is no greater
>> than 1.  Looking at the context of mxsfb_set_par(), mxsfb_restore_mode() and
>
> Why is that? The clock framework handles ref counting for you. All the
> driver needs to take care of is to call as many times disable as it
> calls enable.

Okay.  I'll remove the check and send another version.

Regards,
Liu Ying

>
>  Tomi
>
>
