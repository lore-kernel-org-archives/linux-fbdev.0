From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 16 Mar 2012 08:07:03 +0000
Subject: RE: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <002d01cd034b$c56f2b00$504d8100$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com> <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
 <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
 <002a01cd0283$1f61b200$5e251600$%han@samsung.com>
 <CAEYLNCrprPE60ZS=_OWuck0JCJMhCxzVErZwuwGpEDYkQq-hXg@mail.gmail.com>
 <001d01cd0315$935cc720$ba165560$%han@samsung.com>
 <CAEYLNCrGCmb5EJjURLY=EGfM=4N54MirNkCCyQRxqKEN3Eka8Q@mail.gmail.com>
In-Reply-To: <CAEYLNCrGCmb5EJjURLY=EGfM=4N54MirNkCCyQRxqKEN3Eka8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



> -----Original Message-----
> From: Darius Augulis [mailto:augulis.darius@gmail.com]
> Sent: Friday, March 16, 2012 4:47 PM
> To: Jingoo Han
> Cc: Thomas Abraham; linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; ben-linux@fluff.org; patches@linaro.org;
> kgene.kim@samsung.com; Kyungmin Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter
> Korsgaard; Maurus Cuelenaere; Tushar Behera
> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> On Fri, Mar 16, 2012 at 3:39 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> 
> >> > So, your code can be removed.
> >>
> >> I don't think so. It does not break anything yet. One who make
> >> changes, should ensure backwards compatibility, at least talking about
> >> functionality and hardware (LCD) support, which was added few months
> >> ago. Remember, we talk about kernel parameters line - now it lets
> >> bootloader to select correct LCD size. After your changes, board with
> >> 7" LCD wont show anything.
> >
> > [CC'ed Tushar Behera]
> >
> > Yes, your code is working. However, your code is bug.
> 
> it's not a bug, because it's working like it was intended to. it was
> reviewed and accepted by maintainers before merging to main line.
> you do not have rights to drop it because you don't like it.
> You are doing changes - please do it correctly and do not break
> existing functionality.
> btw, you still not answered my question: why these two s3c_fb_pd_win
> structures in mach-mini6410.c is a problem? They are declared on the
> stack, but platform data uses only single one. mini6410 rewrites its
> s3c-fb platform data with data from one of these two structures
> dynamically. Why it's a bug? You want to remove this dynamic selection
> which could be leaved there with reworked framework too.


It's just bug.

struct s3c_fb_pd_win should be used for windows of FIMD IP.
It should not be used for selecting multi-LCDs.

struct s3c_fb_pd_win should include information of windows of FIMD IP, s3c_fb_pd_win[0], s3c_fb_pd_win[1] represents window 0,
window 1 of FIMD IP. However, your code includes information of LCD, it means that struct s3c_fb_pd_win represents 4.3" LCD, 7.0"
LCD. It is wrong usage.


> 
> > 'struct s3c_fb_pd_win' is used not for LCD, but for windows of FIMD IP. So, 'struct s3c_fb_pd_win'
> should not be used to select LCD.
> > The mach-aquila.c uses two 'struct s3c_fb_pd_win' like you, however 'struct s3c_fb_pd_win' don't make
> problem with Thomas's
> > patchset. It is because mach-aquila.c use 'struct s3c_fb_pd_win' for only windows of FIMD IP.
> > We don't have to responsibility to keep wrong code. If you have kept the rule, Thomas's patch would
> not make the compatibility
> > problem with your code. Why we should keep aberration such as your code? If you want to select two
> LCDs, please find other way.
> >
> >
> >>
> >> Darius A.
> >

