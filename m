From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 17 Dec 2013 16:27:34 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <CAHkRjk6_+dQTqaOqu4bittwFB5PC9qR8GDKhNDmc=3i15xvTFg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12 December 2013 17:13, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The CLCD driver is used on ARM reference models for ARMv8 so add ARM64
> to the list of dependencies. The driver also has no build time dependencies
> on ARM (stubs are provided for ARM-specific DMA functions in the code) so
> make it available with COMPILE_TEST in order to maximise build coverage.

I haven't followed other CLCD patches but for arm64 it requires
support for DT. I have been carrying some patches (done by Linaro) for
a long time and Pawel @ ARM has another set of patches. Do you know
what the status for those is before enabling CLCD on arm64? That's
unless you are only looking at compile-testing.

-- 
Catalin
