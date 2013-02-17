From: Andi Shyti <andi@etezian.org>
Date: Sun, 17 Feb 2013 14:46:45 +0000
Subject: Re: [PATCH v2 1/1] OMAP4: DSS: Add panel for Blaze Tablet boards
Message-Id: <20130217144645.GB5228@jack.whiskey>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360338220-12753-2-git-send-email-ruslan.bilovol@ti.com>
In-Reply-To: <1360338220-12753-2-git-send-email-ruslan.bilovol@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Ops, sorry, I have to resend the e-mail since I used a mail
address which is not subscribed to the lkml.

Andi

On Sun, Feb 17, 2013 at 03:17:57PM +0100, Andi Shyti wrote:
> > >> +     char name[30];
> > >> +     char buf[50];
> > >> +
> > >> +     if (size >= sizeof(buf))
> > >> +             size = sizeof(buf);
> > >
> > > what's the point of this?
> > 
> > This is a way to limit copied from userspace data by available buffer size,
> > widely used in current kernel sources. Are you implying there is some
> > better (more graceful) way?
> 
> No indeed :)
> There is no other way, sorry for polluting the review :)
> 
> > >> +     if ((pins[2] & 1) || (pins[3] & 1)) {
> > >> +             lanes |= (1 << 1);
> > >> +             ret |= tc358765_write_register(dssdev, PPI_D0S_CLRSIPOCOUNT,
> > >> +                                                     board_data->clrsipo);
> > >> +     }
> > >> +     if ((pins[4] & 1) || (pins[5] & 1)) {
> > >> +             lanes |= (1 << 2);
> > >> +             ret |= tc358765_write_register(dssdev, PPI_D1S_CLRSIPOCOUNT,
> > >> +                                                     board_data->clrsipo);
> > >> +     }
> > >> +     if ((pins[6] & 1) || (pins[7] & 1)) {
> > >> +             lanes |= (1 << 3);
> > >> +             ret |= tc358765_write_register(dssdev, PPI_D2S_CLRSIPOCOUNT,
> > >> +                                                     board_data->clrsipo);
> > >> +     }
> > >> +     if ((pins[8] & 1) || (pins[9] & 1)) {
> > >> +             lanes |= (1 << 4);
> > >> +             ret |= tc358765_write_register(dssdev, PPI_D3S_CLRSIPOCOUNT,
> > >> +                                                     board_data->clrsipo);
> > >> +     }
> > >
> > > Can't this be done in one single multiwrighting command since
> > > this registers are consecutive?
> > >
> > > You build once the array to write and you send it at once.
> > 
> > In this particular case I disagree. Yes, it will be a little bit
> > faster, however:
> > 1) we write this for panel initialization only (so no impact in other cases)
> > 2) multiwriting of array will make code reading more difficult
> > 
> > So I would like to leave it as-is
> > Same is for next your similar comment.
> 
> If the hw is providing us some ways for simplifying the code I
> would use it. In this case we are talking about the i2c feature
> of multiwriting and multireading.
> 
> Let's assume that we want to write on 8 different consecutive
> registers. In my opinion this aproach is quite "heavy":
> 
>   uX register;
> 
>   register = value1;
>   i2c_write(REG1, register);
> 
>   register = value2;
>   i2c_write(REG2, register);
> 
>   ...
> 
> Usually what I do is this:
> 
>   uX register[8];
> 
>   for (i = 0; i < 8; i++)
>     register |= valuei << i; (or register[i] = valuei or whatever)
> 
>   i2c_multi_write(REG, register, 8);
> 
> of course this is a simplified example in pseudocode. I think
> it's more readable and we are making a better use of the i2c
> protocol.
> 
> In your case you have some if statement that are making the multi
> writing more difficult, but still is not impossible.
> 
> At the end it's still a matter of taste, so that you are free to
> choose whatever you prefer :)
> 
> Andi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
