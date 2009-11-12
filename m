From: Eric Miao <eric.y.miao@gmail.com>
Date: Thu, 12 Nov 2009 01:05:48 +0000
Subject: Re: [PATCH 0/8] enable pxa168 LCD on two platform
Message-Id: <f17812d70911111705v57317d32s3805654d9a7ff75@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100011x60a354b0mf2e27e1c5fd0422@mail.gmail.com>
	<20091111155058.4f8d355e.akpm@linux-foundation.org>
In-Reply-To: <20091111155058.4f8d355e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 12, 2009 at 7:50 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 10 Nov 2009 16:11:56 +0800
> Jun Nie <niej0001@gmail.com> wrote:
>
>> To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
>
> I don't think linux-fbdev@vger.kernel.org exists?  You wanted
> linux-fbdev-devel@lists.sourceforge.net ?
>
>> Subject: [PATCH 0/8] enable pxa168 LCD on two platform
>> Date:         Tue, 10 Nov 2009 16:11:56 +0800
>> Sender: linux-fbdev-owner@vger.kernel.org
>>
>> This serial patches add LCD controller SPI support and enable frame
>> buffer on two platform. Several small fix are included.
>> comments from Eric and Russell are addressed.
>>
>>
>>  arch/arm/configs/pxa168_defconfig       |   86 +++++++++++++++-
>>  arch/arm/configs/pxa910_defconfig       |   39 +++++++-
>>  arch/arm/mach-mmp/aspenite.c            |  176 +++++++++++++++++++++++++++++++
>>  arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
>>  arch/arm/mach-mmp/include/mach/pxa910.h |    8 ++
>>  arch/arm/mach-mmp/pxa168.c              |    3 +
>>  arch/arm/mach-mmp/pxa910.c              |    4 +
>>  arch/arm/mach-mmp/ttc_dkb.c             |  140 ++++++++++++++++++++++++
>>  drivers/gpio/pca953x.c                  |    1 +
>>  drivers/video/pxa168fb.c                |  102 ++++++++++++++++++
>>  drivers/video/pxa168fb.h                |   24 +----
>>  include/video/pxa168fb.h                |   49 ++++++++-
>>  12 files changed, 612 insertions(+), 28 deletions(-)
>
> hm.  So who should review and merge these patches??
>

Hi Andrew,

I'm looking into this - actually this is the 2nd round, and I'd like
this to go through my tree since these are really pretty close to
the pxa168/910 stuff if you feel OK.

> The patches were wordwrapped by your email client.  I had that all
> fixed up but the final patch gets a large number of rejects, perhaps
> against the ARM changes in linux-next so I gave up.
>

Jun,

Could you please reply each of your mail with an attachment of
the patch you formatted with 'git-format-patch'. My guess is you
are using Gmail web interface so there might be wrapping issues.
