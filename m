From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Mon, 14 Jun 2010 23:26:03 +0000
Subject: Re: Question regarding submitting a new SOC fb driver
Message-Id: <AANLkTik16jWmjeupC-kshMdVWT6zj7RLuskdZ2j_yqWY@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTik1FGeojNP4xlDF_0r4p92dYltIkDCxuTGNCsty@mail.gmail.com>
In-Reply-To: <AANLkTik1FGeojNP4xlDF_0r4p92dYltIkDCxuTGNCsty@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Jun 15, 2010 at 4:55 AM, Erik Gilling <konkers@google.com> wrote:
> I'm going to be submitting a pull request to linux-next later this
> week for our initial tegra support. =A0Should I include our framebuffer
> driver in that tree or send it upstream through this list? =A0The driver
> has been sent to this list and reviewed.
>
> git://android.git.kernel.org/kernel/tegra.git =A0for-next
>
> Thanks,
> =A0 =A0Erik
>

Hi Erik,

Thanks for asking on the list. If the driver you mentioned has been
acked by other developers and you feel that there's been a decent
amount of review by fbdev folks then all is well, and sending it
upstream through linux-next sounds good. If it hasn't, then I highly
recommend giving the fbdev folks some time to take a look at it. (
Maybe throw in a tegra board to anyone who finds/fixes bugs in the
code :-) )

Thanks,
jaya
