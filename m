From: Kyungmin Park <kyungmin.park@samsung.com>
Date: Fri, 02 Dec 2011 08:57:35 +0000
Subject: Re: backlight/ld9040.c: regulator control in the lcd driver
Message-Id: <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
 <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
In-Reply-To: <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/2/11, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 2, 2011 at 8:45 AM, leedonghwa <dh09.lee@samsung.com> wrote:
>
> [From your mail headers]
>> X-Mailer: Microsoft Office Outlook 12.0
>
> No please. That mailer does not work, all your whitespace is screwed up.
> Consult: Documentation/email-clients.txt
>
>> This patch supports regulator power control in the driver.
>
> Always CC the regulator maintainers on patches like this please.
>
>> +         lcd->reg_vdd3 = regulator_get(lcd->dev, "vdd");
>> +         if (IS_ERR(lcd->reg_vdd3)) {
>> +                   dev_info(lcd->dev, "no %s regulator found\n", "vdd");
>> +                   lcd->reg_vdd3 = NULL;
>> +         }
>> +
>> +         lcd->reg_vci = regulator_get(lcd->dev, "vci");
>> +         if (IS_ERR(lcd->reg_vci)) {
>> +                   dev_info(lcd->dev, "no %s regulator found\n", "vci");
>> +                   lcd->reg_vci = NULL;
>> +         }
>
> As explained in earlier discussion with Mark regarding the SMSC911x
> driver regulator, treat these as errors and do not fail
> "gracefully" like this.
>
> Reference:
> http://marc.info/?l=linux-netdev&m1914562120725&w=2

As mentioned at commit message, the lcd regulator is optional part and
refer the mmc codes

        host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
        if (IS_ERR(host->vmmc)) {
                pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
                host->vmmc = NULL;
        } else {
                regulator_enable(host->vmmc);
        }

Previous time, these codes are located at board file, but more boards
are used, it has same codes for all boards. so move it to drivers.

In our case, it has the regulator but some boards don't.

Umm then how to handle the regulator gracefully?

Thank you,
Kyungmin Park

>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
