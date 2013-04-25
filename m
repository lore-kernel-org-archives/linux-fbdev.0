From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 25 Apr 2013 09:42:06 +0000
Subject: Re: [PATCHv2 0/2] Add support for the Solomon SSD1306 OLED Controller
Message-Id: <5178FA6E.2050709@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Andrew,

Le 22/04/2013 11:55, Maxime Ripard a =E9crit :
> This patchset adds the needed bits to the ssd1307fb driver to support the
> very similar Solomon SSD1306 controller.
>=20
> Since the SSD1307 has been replaced by the SSD1306 in the latest CFA-10036
> production samples, we also need to change the device tree accordingly.

These patches have been around for more than a month and a half now,
without anyone making any comments on it.

I know that you have taken framebuffer patches in the past, especially
the driver that this patch modifies, would you consider merging it
through your tree?

I begin to have patches that depends on this one (the patchset "drivers:
video: Optimisations for the ssd1307fb driver"). I understand that we
are quite close to the 3.10 merge window opening (we even reached the
end of it for the ARM part, so the second patch will only be in 3.11),
but I'd like to make sure that this patch and the others doesn't get
silently ignored.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
