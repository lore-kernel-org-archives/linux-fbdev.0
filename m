From: Timur Tabi <timur@tabi.org>
Date: Tue, 24 Nov 2015 17:02:12 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <CAOZdJXXp-Bs4=1sfThmGquVs1mWXEHYb8rgB6muRWCnoniEeZg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 24, 2015 at 11:55 AM, Scott Wood <scottwood@freescale.com> wrote:

>> Well, if you're concern is that there's no platform code, then there
>> should be a check that says, "see if there's any platform code", not
>> "let's check this obscure function and abort without explanation if
>> it's not initialized."
>
> Do you have a *specific* better way to "see if there's any platform code"?

Well, for one thing, the check should be done in the _init function,
not the _probe.  Secondly, it should be documented as such, e.g. "/*
Check to see that we have platform code that initializes diu_ops.  If
not, then abort. */".  Third, you should probably add a boolean field
to platform_diu_data_ops that gets set to True if/when the platform
code initializes the rest of the structure.

Of course, an even better solution would be to get rid of the global
structure altogether and come up with something more robust, but I
understand that that's overkill.
