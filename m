From: Dave Airlie <airlied@gmail.com>
Date: Sat, 21 Nov 2009 04:25:27 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <21d7e9970911202025g57f72ecexbe29d6ac150153bb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
In-Reply-To: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sat, Nov 21, 2009 at 6:48 AM, James Simmons <jsimmons@infradead.org> wro=
te:
>
>
> On Fri, 20 Nov 2009, Paulius Zaleckas wrote:
>
>> On 11/20/2009 10:01 PM, James Simmons wrote:
>> >
>> > > > > > Paulius Zaleckas wrote:
>> > > > > > > On drivers using drm_fb_helper's in fb_ops it is not possibl=
e to
>> > > > > > > change
>> > > > > > > video mode, because of different var->pixclock evaluation: .=
..
>> > > > > >
>> > > > > > patch:
>> > > > > > http://www.mail-archive.com/dri-devel@lists.sourceforge.net/ms=
g44369.html
>> > > > >
>> > > > > Those patches will enable fbdev apps to run properly. More patch=
es are
>> > > > > needed if you want to support mode switching using the fbdev emu=
lation
>> > > > > layer. I noticed my patches and yours where lost. Who do you send
>> > > > > patches
>> > > > > too that can merge them ?
>> > > >
>> > > > y:/usr/src/git26> =A0 perl scripts/get_maintainer.pl -f
>> > > > drivers/gpu/drm/drm_fb_helper.c
>> > > > David Airlie<airlied@linux.ie>
>> > > > Dave Airlie<airlied@redhat.com>
>> > > > Jesse Barnes<jbarnes@virtuousgeek.org>
>> > > > Mikael Pettersson<mikpe@it.uu.se>
>> > > > dri-devel@lists.sourceforge.net
>> > > > linux-kernel@vger.kernel.org
>> > > >
>> > > > That's accurate enough.
>> > > >
>> > > > Generally, if nothing has happened in a week, the chances that it's
>> > > > lost are very high. =A0Resend. =A0If you like, cc me and I'll main=
tain the
>> > > > patches
>> > > > and resend them for you.
>> > >
>> > > You can add Tested-by: Paulius Zaleckas<paulius.zaleckas@gmail.com>
>> > > for
>> > > http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44369=
.html
>> > > as this was preventing DirectFB from running on my Asus Eee PC 701.
>> >
>> > I tested it as well with the both my 3Dfx driver that I wrote with KMS=
 and
>> > the nouveau driver. We just need to make sure that the patches end up =
in
>> > the drm-next tree or these patches will be lost when drm-next gets mer=
ged
>> > to linus tree.
>>
>> IMHO this patch should end up in current (2.6.32) kernel and we should
>> send it to stable ML.
>
> Honestly I like to see it there as well.
>

I have them queued for drm-next already at least locally, I wasn't aware
they were suitable for final, I didn't get a chance to really test them unt=
il
last week and make sure they didn't hide any side effects. I can
ask for them to go to stable when the merge window opens, I think
its too late for final.

Dave.
