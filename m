From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 31 Mar 2010 12:15:53 +0000
Subject: Re: [PATCH v6 7/8, needs improvement] hid: add suspend/resume hooks
Message-Id: <alpine.LNX.2.00.1003311415000.24576@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz> <20100327012245.0ace6a09@neptune.home>
 <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz> <20100329121611.0c22dcaf@pluto.restena.lu> <alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz> <20100330223224.18fe4f3e@neptune.home> <20100330224230.7b84df75@neptune.home>
In-Reply-To: <20100330224230.7b84df75@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Tue, 30 Mar 2010, Bruno Prémont wrote:

> Add suspend/resume hooks for HID drivers so these can do some
> additional state adjustment when device gets suspended/resumed.
> 
> This patch calls these hooks from usbhid suspend/resume functions,
> only calling suspend on plain suspend, not autosuspend.
> (it might be worth adding an autosuspend parameter to suspend
> hook and calling suspend in both cases)
> 
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
> 
> Note:
>   this patch needs improvements as mentionned by Olivier Neukum:
>   - suspend hook for both system suspend and autosuspend
>   - no call of hook on USB-HID-resume failure

I agree with Oliver's comments.

We should also consider putting the hook calls into bluetooth 
implementation as well (though there is currently no driver using it, but 
I don't know, maybe Wacom could benefit from it as well).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
