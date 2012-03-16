From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 16 Mar 2012 01:39:06 +0000
Subject: RE: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <001d01cd0315$935cc720$ba165560$%han@samsung.com>
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
In-Reply-To: <CAEYLNCrprPE60ZS=_OWuck0JCJMhCxzVErZwuwGpEDYkQq-hXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



> -----Original Message-----
> From: Darius Augulis [mailto:augulis.darius@gmail.com]
> Sent: Thursday, March 15, 2012 5:27 PM
> To: Jingoo Han
> Cc: Thomas Abraham; linux-fbdev@vger.kernel.org; FlorianSchandinat@gmx.de; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; kgene.kim@samsung.com; ben-
> linux@fluff.org; patches@linaro.org; Kyungmin Park; JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark
> Brown; Peter Korsgaard; Maurus Cuelenaere
> Subject: Re: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> On Thu, Mar 15, 2012 at 10:10 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> 
> >> There is single board - mini6410 (or real6410) and it's name doesn't
> >> depend on connected LCD size.
> >> We know, that this board is available with different sizes of LCD and
> >> currently we have in kernel support for both sizes.
> >> It might be so, that it's implemented not in perfect way, but it was
> >> accepted and at least it's working.
> >
> >
> > I don't think so.
> > You argues that the wrong code should not be removed because it was accepted and at least it's working.
> > It is just wrong usage, which can just work.
> > Moreover, your code will make the problem, when 2~5 windows of FIMD IP are used.
> 
> Could please explain that? How does LCD feature selection for mini6410
> and real6410 break that?
> Timing for different sizes of LCD is located in two statically
> allocated structures which are used at board init time depending on
> kernel param line.
> Data from one of these structures is copied to s3c-fb platform data
> dynamically by board init code. Why it's a problem? What changes if
> platform data isn't rewritten dynamically?
> 
> > So, your code can be removed.
> 
> I don't think so. It does not break anything yet. One who make
> changes, should ensure backwards compatibility, at least talking about
> functionality and hardware (LCD) support, which was added few months
> ago. Remember, we talk about kernel parameters line - now it lets
> bootloader to select correct LCD size. After your changes, board with
> 7" LCD wont show anything.

[CC'ed Tushar Behera]

Yes, your code is working. However, your code is bug.
'struct s3c_fb_pd_win' is used not for LCD, but for windows of FIMD IP. So, 'struct s3c_fb_pd_win' should not be used to select LCD.
The mach-aquila.c uses two 'struct s3c_fb_pd_win' like you, however 'struct s3c_fb_pd_win' don't make problem with Thomas's
patchset. It is because mach-aquila.c use 'struct s3c_fb_pd_win' for only windows of FIMD IP.
We don't have to responsibility to keep wrong code. If you have kept the rule, Thomas's patch would not make the compatibility
problem with your code. Why we should keep aberration such as your code? If you want to select two LCDs, please find other way.


> 
> Darius A.

