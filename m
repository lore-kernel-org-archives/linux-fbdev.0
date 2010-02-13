From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 13 Feb 2010 14:35:54 +0000
Subject: Re: [PATCH 00/02] sh: Panning fixes
Message-Id: <aec7e5c31002130635o3db70c16oe0f89ea550682260@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Phil,

On Fri, Feb 12, 2010 at 5:45 AM, Phil Edworthy
<Phil.Edworthy@renesas.com> wrote:
> Hi Magnus,
>
>> Thanks for your patches. Please make sure that the SYS panel case with
>> deferred io is working. Migo-R is a good board to test this on.
>
> I thought the Migo-R doesn't have vsync connected to the SH, so maybe this
> patch won't show any difference. Is that your understanding?

Something like that, I think the QVGA LCD panel on Migo-R does not
expose the VSYNC pin of the on-panel LCD controller so there is
nothing to connect to the sh7722.

It may be difficult to test your patch because of this, I'm not sure.
My main concern was just to double check that you've thought about
dealing with both the deferred io case and the "regular" non-deferred
io case. The sh7724 KFR2R09 board is using deferred io and I think
some upcoming boards may make use of that as well, so I'd prefer to
keep that case working. =)

Cheers,

/ magnus
