From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Tue, 14 Jun 2011 08:20:45 +0000
Subject: Re: [PATCH 0/4] fbdev: au1200fb updates
Message-Id: <BANLkTin=GXU333wCevGg8obA-LvF8aqZAQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307719384-23702-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1307719384-23702-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Paul,

On Tue, Jun 14, 2011 at 9:26 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Jun 10, 2011 at 05:23:00PM +0200, Manuel Lauss wrote:
>> Here are 4 updates to the au1200fb codebase to get it to work and compile
>> again, also with PM enabled.
>>
>> Run and PM-tested on DB1200 and DB1300.
>>
>> Manuel Lauss (4):
>> =A0 au1200fb: use framebuffer_alloc()
>> =A0 au1200fb: fixup PM
>> =A0 au1200fb: make number of windows configurable at load time.
>> =A0 au1200fb: switch to FB_SYS helpers
>>
>> =A0drivers/video/Kconfig =A0 =A0| =A0 =A07 +-
>> =A0drivers/video/au1200fb.c | =A0285 ++++++++++++++++++++---------------=
-----------
>> =A02 files changed, 128 insertions(+), 164 deletions(-)
>>
> This is quite a bit bigger than something I would generally like to push
> along for -rc4 timing. Patches 1, 2, and 4 all technically qualify as
> fixes, so those are workable. 3/4 on the other hand looks like a feature
> enhancement that you're either dependent on for your new platform or a
> cleanup to move off of the previous hardcoding (in either case not really
> -rc4 material).
>
> On the other hand, if you don't require any of these for -rc4 then I can
> just apply the whole batch aimed at the next merge window.

next merge window is fine.  the driver has been in this state for ages, so
another few weeks really don't matter.

Thanks!
        Manuel Lauss
