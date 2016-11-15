From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Nov 2016 16:30:59 +0000
Subject: Re: [GIT PULL] fbdev fixes for 4.9
Message-Id: <CA+55aFwq-iSOfK2MbWEH3EMyJANqvMTekRwEw6we-vFSMVB2_Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com> <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com>
 <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
In-Reply-To: <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>

On Tue, Nov 15, 2016 at 3:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> I did test compile, and I would have noticed errors but I missed the warnings
> (I blame the flu...). I need to improve my testing methods, but I couldn't find
> a way to add -Werror to kernel builds. I guess I should just always capture the
> warnings and errors to a file, and check that after the build.
>
> How do you test build?

I basically do just an allmodconfig build, but I do it with

    make -j16 > ../make-output

so that any warnings are very obvious (because stdout goes elsewhere).

              Linus
