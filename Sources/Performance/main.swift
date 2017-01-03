/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   main.swift
 *  Project         :   HTMLString/Performance
 *  Author          :   Alexis Aubry Radanovic
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 * A tool to measure the performance of escaping and unescaping.
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016-2017 Alexis Aubry Radanovic
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import Foundation
import Dispatch
import HTMLString

// MARK: Configuration

let averageTimeSamplesCount = 1_000
let version = "2.1.0"

let tasks = [
    1: "Unicode-escaping 2 emojis",
    2: "ASCII-escaping 2 emojis",
    3: "Unescaping 2 emojis",
    4: "Unescaping a tweet",
    5: "Unicode-escaping a tweet",
    6: "ASCII-escaping a tweet",
    7: "Unicode-escaping 23,145 characters",
    8: "ASCII-escaping 23,145 characters",
    9: "Unescaping 3,026 words with 366 escapes"
]

let history: Dictionary<String, [Int:TimeInterval]> = [
    :
]



// MARK: - Utility

func measure(_ block: () -> Void) -> TimeInterval {

    var times = [TimeInterval]()
    times.reserveCapacity(averageTimeSamplesCount)

    while times.count < averageTimeSamplesCount {

        let start = DispatchTime.now()
        block()
        let end = DispatchTime.now()

        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = TimeInterval(nanoTime) / 1_000_000_000

        times.append(timeInterval)

    }

    let sum = times.reduce(Double()) { $0 + $1 }
    let average = sum / Double(averageTimeSamplesCount)

    return Double(round(1_000_000*average)/1_000_000) // +/- 10^-6 average

}

// MARK: - Data

let bigEscapableText = "Informations et mentions légales Propriété du site ; acceptation des conditions d'utilisation Les présentes conditions générales d'utilisation (les « Conditions d'utilisation ») s'appliquent au site web d'Apple sis à l'adresse www.apple.com et à tous les sites associés liés au site www.apple.com par Apple, ses filiales et sociétés affiliées, dans le monde entier (collectivement désignés par le terme le « Site »). Le Site est la propriété d'Apple Inc. (« Apple ») et de ses concédants. EN UTILISANT LE SITE, VOUS ACCEPTEZ LES PRÉSENTES CONDITIONS D'UTILISATION ; SI VOUS NE LES ACCEPTEZ PAS, VEUILLEZ NE PAS UTILISER LE SITE. Apple se réserve le droit, à sa seule discrétion et à tout moment, de changer, modifier, compléter ou supprimer des parties de ces Conditions d'utilisation. Il est de votre responsabilité de consulter périodiquement ces Conditions d'utilisation pour voir si des modifications y ont été apportées. Si vous continuez à utiliser le Site après publication des modifications apportées, cela signifiera que vous acceptez lesdites modifications. Tant que vous vous conformez aux présentes Conditions d'utilisation, Apple vous accorde un droit personnel limité, non exclusif et non cessible d'accès au Site et d'utilisation du Site. Contenu L'ensemble des textes, graphiques, interfaces utilisateur, interfaces visuelles, photographies, marques commerciales, logos, sons, musiques, illustrations et codes informatiques (collectivement désignés par le terme le « Contenu »), notamment le design, la structure, la sélection, la coordination, l'expression, l'aspect et la convivialité, la présentation et l'agencement de ce Contenu, figurant sur le Site est détenu, contrôlé ou cédé sous licence par ou à Apple, et est protégé par la législation sur l'habillage commercial, les droits d'auteur, les brevets et les marques, et diverses autres lois applicables en matière de propriété intellectuelle et de concurrence déloyale. Sauf mention expresse figurant dans les présentes Conditions d'utilisation, aucune section du Site ni aucun Contenu ne peuvent être copiés, reproduits, republiés, téléchargés, publiés, exposés en public, encodés, traduits, transmis ou diffusés de quelque façon que ce soit (y compris par « écriture miroir ») sur un autre ordinateur, serveur, site web ou support de publication ou de diffusion, ou pour quelque entreprise commerciale que ce soit, sans l'accord écrit préalable d'Apple. Vous pouvez utiliser les informations sur les produits et les services Apple (telles que les fiches techniques, les articles de la base de connaissances et informations similaires) mis à disposition à dessein par Apple en vue de leur téléchargement, dans la mesure où (1) vous ne supprimez pas les avis de droits d'auteur sur les copies de ces documents, (2) vous utilisez ces informations pour votre usage personnel et à des fins non commerciales et vous ne copiez pas et ne publiez pas ces informations sur un ordinateur en réseau et vous ne les diffusez pas dans quelque média que ce soit, (3) vous n'apportez pas de modifications à ces informations et (4) vous n'accordez aucun engagement ni aucune garantie quant à la teneur de ces documents. Utilisation du Site Vous n'êtes pas autorisé à utiliser des dispositifs, programmes, algorithmes ou autres méthodes automatiques de type « lien profond », « gratte-pages », « robot » ou « araignée », ou tout autre processus manuel similaire ou équivalent, pour accéder à, acquérir, copier ou surveiller toute partie du Site ou du Contenu, ni à reproduire ou contourner la structure navigationnelle ou la présentation du Site ou du Contenu pour vous procurer ou essayer de vous procurer des données, des documents ou des informations par des moyens non mis à dessein à votre disposition par le biais du Site. Apple se réserve le droit d'interdire ce type d'activité. Vous ne devez pas essayer d'accéder de façon illicite à toute section ou fonctionnalité du Site, ni à tout autre système ou réseau connecté au Site ou à un serveur Apple, ni aux services offerts sur ou par l'intermédiaire du Site, par piratage informatique, « reniflage » de mots de passe ou tout autre moyen illégitime. Vous ne devez pas essayer de sonder, d'analyser ou de tester la vulnérabilité du Site ou de tout réseau connecté au Site, ni enfreindre les mesures de sécurité et d'authentification mises en place sur le Site ou les réseaux connectés au Site. Vous n'êtes pas autorisé à rétro-interroger, tracer ou essayer de tracer les informations sur les autres utilisateurs ou visiteurs du Site, ou les autres clients d'Apple, notamment tout compte Apple dont vous n'êtes pas le détenteur ou sa source, ni à exploiter le Site ou les services ou les informations mis à disposition ou offerts sur ou via le Site, de quelque manière que ce soit, dans le but de révéler ces informations, notamment les informations d'identification personnelles ou les informations autres que vos propres informations, telles qu'elles apparaissent sur le Site. Vous vous engagez à ne prendre aucune mesure qui imposerait une charge excessive ou déraisonnable sur l'infrastructure du Site ou des systèmes ou des réseaux d'Apple, ou de tout système ou réseau connecté au Site ou à Apple. Vous vous engagez à n'utiliser aucun dispositif, logiciel ou sous-programme pour interférer ou essayer d'interférer sur le bon fonctionnement du Site ou de toute transaction conduite sur le Site ou sur l'utilisation du Site par toute autre personne. Vous ne devez pas essayer de contrefaire les en-têtes ou manipuler les identifiants de quelque manière que ce soit pour déguiser l'origine d'un message ou d'une transmission envoyé à Apple sur ou via le Site, ou d'un service offert sur ou via le Site. Vous ne devez pas prétendre être ou représenter quelqu'un d'autre, ni vous faire passer pour une autre entité physique ou morale. Vous ne devez pas utiliser le Site ou son Contenu dans un dessein illicite ou prohibé par les présentes Conditions d'utilisation, ni en vue d'encourager toute activité illégale ou autre portant atteinte aux droits d'Apple ou de tiers. Achats ; autres conditions générales Des conditions générales annexes pourront s'appliquer à des achats de biens ou de services, ainsi qu'à des sections ou fonctionnalités spécifiques du Site, notamment les concours, promotions et autres offres similaires, lesdites conditions étant intégrées aux présentes Conditions d'utilisation à titre de référence. Vous acceptez de vous conformer à ces conditions générales annexes, en confirmant notamment le cas échéant avoir l'âge légal requis pour utiliser ou participer au service ou à l'offre concerné. En cas de contradiction entre les présentes Conditions d'utilisation et les conditions publiées pour, ou applicables à une section spécifique du Site ou pour un service offert sur ou via le Site, ces dernières conditions prévaudront et régiront l'utilisation de cette section du Site ou de ce service spécifique. Le cas échéant, les obligations d'Apple vis-à-vis de ses produits et services sont régies uniquement par les conventions aux termes desquelles elles ont été définies et aucun élément figurant sur ce Site ne saurait être interprété de façon à modifier ces conventions. Apple pourra apporter des changements aux produits et services offerts sur le Site ou aux prix applicables à ces produits et services à tout moment et sans préavis. Les informations publiées sur le Site concernant des produits et des services peuvent être obsolètes, et Apple ne s'engage nullement à mettre à jour les informations publiées sur le Site relatives à ces produits et services. Les conditions générales ci-après concernent et régissent également l'utilisation du Site, et sont incorporées ici à titre de référence : Informations relatives aux marques commerciales Informations relatives aux droits d'auteur Droits et autorisations Actions en violation de droits d'auteur Lutte contre le piratage Signaler un acte de piratage Politique d'Apple en matière de soumission d'idées non sollicitées Informations sur les licences de logiciels Contacts juridiques Les règles et politiques énoncées pourront être modifiées de temps en temps et seront applicables dès la publication de ces modifications sur le Site. Comptes, mots de passe et sécurité Certains services et fonctionnalités offerts sur ou via le Site peuvent nécessiter l'ouverture d'un compte (y compris la configuration d'un identifiant Apple et d'un mot de passe). Vous avez l'entière responsabilité de préserver la confidentialité des informations relatives à votre compte, notamment votre mot de passe, et de toutes les opérations effectuées sous votre compte. Vous vous engagez à prévenir Apple immédiatement en cas d'utilisation non autorisée de votre compte ou de votre mot de passe, ou de toute violation de la sécurité. Toutefois, vous pourrez être tenu pour responsable des préjudices subis par Apple ou par tout autre utilisateur ou visiteur du Site dû à l'utilisation de votre identifiant Apple, votre mot de passe ou votre compte par une autre personne. Vous n'êtes pas autorisé à utiliser l'identifiant Apple, le mot de passe ou le compte d'une autre personne, à quelque moment que ce soit, sans l'autorisation et l'accord explicites du détenteur de cet identifiant Apple, de ce mot de passe ou de ce compte. Apple ne pourra être tenue pour responsable des préjudices découlant de votre manquement à respecter ces obligations. Confidentialité L'Engagement de confidentialité d'Apple s'applique à l'utilisation de ce Site, et ses conditions sont intégrées aux présentes Conditions d'utilisation à titre de référence. Pour consulter l'Engagement de confidentialité d'Apple, cliquez ici. En outre, en utilisant ce Site, vous reconnaissez et acceptez le fait que les transmissions via Internet ne sont jamais totalement confidentielles et sûres. Vous comprenez le fait que tout message ou toute information que vous transmettez au Site peut être lu ou intercepté par d'autres, même si un avis spécial précise qu'une transmission donnée (coordonnées de carte bancaire, par exemple) est chiffrée. Liens vers d'autres sites et vers le site Apple Ce Site peut contenir des liens vers d'autres sites web tiers indépendants (les « Sites liés »). Ces Sites liés sont indiqués uniquement à titre de commodité pour nos visiteurs. Ces Sites liés ne sont pas sous le contrôle d'Apple, et Apple n'est pas responsable et n'avalise pas le contenu de ces Sites liés, y compris des informations qui y sont publiées. Vous devrez vous faire votre propre jugement concernant vos interactions avec ces Sites liés. Exclusions de garantie APPLE NE GARANTIT PAS QUE LE SITE OU SON CONTENU OU LES SERVICES ET FONCTIONNALITÉS OFFERTS SUR LE SITE SERONT EXEMPTS D'ERREURS OU ACCESSIBLES DE FAÇON ININTERROMPUE, QUE LES DÉFAUTS ÉVENTUELS SERONT CORRIGÉS, NI QUE L'UTILISATION DU SITE PRODUIRA DES RÉSULTATS SPÉCIFIQUES. LE SITE ET SON CONTENU SONT FOURNIS SUR UNE BASE « EN L'ÉTAT » ET « SOUS RÉSERVE DE DISPONIBILITÉ ». TOUTES LES INFORMATIONS FOURNIES SUR LE SITE SONT SUSCEPTIBLES D'ÊTRE MODIFIÉES SANS PRÉAVIS. APPLE NE PEUT GARANTIR QUE LES FICHIERS ET LES DONNÉES QUE VOUS TÉLÉCHARGEZ DEPUIS LE SITE SERONT EXEMPTS DE VIRUS, DE CONTAMINATION OU DE FONCTIONNALITÉS MALVEILLANTES. APPLE REJETTE TOUTE FORME DE GARANTIE, EXPLICITE OU IMPLICITE, NOTAMMENT TOUTE GARANTIE D'EXACTITUDE, DE NON-CONTREFAÇON, DE QUALITÉ MARCHANDE OU D'ADAPTATION À UN USAGE PARTICULIER. APPLE REJETTE ÉGALEMENT TOUTE RESPONSABILITÉ AU REGARD DES ACTES, DES OMISSIONS OU DU COMPORTEMENT DE TIERS EN CONNEXION OU ASSOCIÉS AVEC VOTRE UTILISATION DU SITE ET/OU DE SERVICES APPLE. VOUS ASSUMEZ L'ENTIÈRE RESPONSABILITÉ QUANT À VOTRE UTILISATION DU SITE ET DES SITES LIÉS. VOTRE SEUL RECOURS CONTRE APPLE EN CAS DE MÉCONTENTEMENT AU REGARD DU SITE OU D'UN CONTENU EST D'ARRÊTER D'UTLISER LE SITE OU LE CONTENU EN QUESTION. CETTE LIMITATION DE MESURE RÉPARATOIRE FAIT PARTIE DE LA TRANSACTION ENTRE LES PARTIES. Les exclusions de garantie ci-dessus concernent l'ensemble des dommages, pertes ou préjudices dus à tout défaut d'exécution, erreur, omission, interruption, suppression, défaut, retard d'exécution ou de transmission, virus informatique, rupture de ligne de communication, vol, destruction, accès illicite ou utilisation, que ce soit pour rupture de contrat, faute professionnelle, négligence ou toute autre cause d'action. Apple se réserve le droit d'effectuer l'une des actions suivantes à tout moment et sans préavis : (1) modifier, suspendre ou bloquer le fonctionnement ou l'accès à tout ou partie du Site, pour quelque motif que ce soit ; (2) modifier tout ou partie du Site et toutes règles ou conditions applicables ; (3) interrompre le fonctionnement de tout ou partie du site, à des fins de maintenance périodique ou non, de correction d'erreurs ou de modifications. Limitation de responsabilité Dans la mesure autorisée par la loi, Apple ne pourra en aucun cas être tenue pour responsable en cas de dommages indirects, exemplaires, accessoires ou punitifs, y compris de toute perte de bénéfice, même si Apple a été prévenue de l'éventualité de tels dommages. Si, nonobstant les autres dispositions des présentes Conditions d'utilisation, Apple était tenue pour responsable de dommages ou de préjudices que vous auriez subis des conséquences de, ou en rapport avec l'utilisation du Site ou de tout Contenu, la responsabilité d'Apple ne pourrait en aucun cas être engagée pour un montant supérieur (1) au total des droits d'abonnement ou droits similaires associés à l'utilisation d'un service ou d'une fonctionnalité du Site payés au cours des six mois précédant la date de la plainte initiale portée contre Apple (à l'exclusion du prix d'achat de tout produit matériel ou logiciel Apple ou de tout programme AppleCare ou programme d'assistance similaire) ou (2) à 100,00 USD. Certaines juridictions n'autorisant pas les limites de responsabilité, il se peut que la limitation susmentionnée ne vous concerne pas. Indemnisation Vous vous engagez à indemniser et à dégager de toute responsabilité Apple, ses dirigeants, administrateurs, actionnaires, prédécesseurs, successeurs, employés, agents, filiales et sociétés affiliées au regard de toute demande, perte, responsabilité financière, réclamation ou dépense (y compris les frais juridiques) résultant d'actions lancées par des tiers à l'encontre d'Apple dues à, ou en rapport avec votre utilisation du Site. Infraction aux présentes conditions d'utilisation Apple pourra divulguer les informations que nous détenons sur vous (y compris votre identité) si nous déterminons qu'une telle divulgation est nécessaire en connexion avec une enquête ou une plainte concernant votre utilisation du Site, ou pour identifier, contacter ou poursuivre une personne soupçonnée de porter préjudice aux, ou d'interférer avec, volontairement ou non, les droits ou la propriété d'Apple ou avec les droits ou la propriété de visiteurs ou d'utilisateurs du Site, y compris les clients d'Apple. Apple se réserve le droit, à tout moment, de divulguer toutes les informations jugées nécessaires pour se conformer à la loi, la réglementation, la voie judiciaire ou une requête du gouvernement. Apple pourra également divulguer vos informations si nous déterminons que la loi en vigueur requiert ou autorise cette divulgation, notamment dans le cadre d'échange d'informations avec d'autres sociétés et organisations à des fins de protection contre la fraude. Vous reconnaissez et acceptez le fait qu'Apple pourra conserver les informations transmises ou communiquées par vous à Apple par l'intermédiaire du Site ou des services offerts sur ou via le Site, et pourra divulguer ces informations dans la mesure où la loi l'exige ou si Apple détermine qu'une telle conservation ou divulgation est raisonnablement nécessaire pour (1) se conformer à la voie du droit, (2) faire appliquer les présentes, (3) réagir à des plaintes pour violation des droits d'autres personnes par ces données, ou (4) protéger les droits, la propriété et la sécurité d'Apple, de ses employés, des utilisateurs et des visiteurs du site, et du public. Vous convenez du fait qu'Apple pourra, à sa seule discrétion et sans préavis, résilier votre droit d'accès au Site et/ou vous empêcher d'accéder au Site à l'avenir s'il est déterminé que vous n'avez pas respecté les présentes Conditions d'utilisation ou d'autres accords ou directives éventuellement associés à l'utilisation du Site. Vous convenez également du fait que toute infraction aux présentes Conditions d'utilisation constituera une pratique commerciale illégale et déloyale, et causera un préjudice irréparable à Apple au regard duquel des dommages-intérêts monétaires seraient inadéquats, et qu'Apple pourra obtenir toute mesure de redressement par voie d'injonction ou en Équité considérée comme nécessaire ou appropriée eu égard aux circonstances. Ces mesures de redressement s'entendent en complément des autres voies de recours d'Apple. Vous convenez du fait qu'Apple pourra, à sa seule discrétion et sans préavis, résilier votre droit d'accès au Site pour un motif déterminé, notamment (1) sur demande d'un organisme d'application de la loi ou d'un autre organisme public, (2) à votre demande (suppression de compte sur demande), (3) en cas d'interruption ou de modification importante du Site ou d'un service offert sur ou via le Site, ou (4) en cas de problèmes techniques inattendus. Si Apple entame des poursuites judiciaires à votre encontre des suites d'une infraction par vous aux présentes Conditions d'utilisation, Apple aura le droit de se faire rembourser par vous, et vous acceptez de payer, les honoraires d'avocat et les frais ainsi encourus, en plus des autres réparations accordées à Apple. Vous convenez du fait qu'Apple ne pourra être tenue pour responsable à votre égard ou à l'égard d'un tiers pour votre résiliation du droit d'accès au Site des suites d'une infraction aux présentes Conditions d'utilisation. Droit applicable ; résolution des litiges Vous convenez du fait que toute matière associée à votre accès ou votre utilisation du Site, y compris les litiges éventuels, sera régie par les lois des États-Unis et par les lois de l'État de Californie, indépendamment des dispositions en matière de conflit des lois. Vous reconnaissez la compétence du tribunal d'État et du tribunal fédéral du comté de Santa Clara, Californie, et renoncez à toute objection quant à cette compétence. Toute réclamation aux termes des présentes Conditions d'utilisation doit être portée dans un délai d'un (1) an à compter de l'occurrence de la cause d'action, après quoi il y aura prescription. Aucun dommage-intérêt autre que les débours ne pourra être recouvré ou perçu, étant entendu que la partie gagnante pourra être remboursée des frais et honoraires d'avocat encourus. En cas de controverse ou de litige entre vous et Apple découlant de, ou en rapport avec votre utilisation du Site, les parties devront essayer de résoudre ce litige rapidement et de bonne foi. En cas d'incapacité à résoudre ce litige dans un délai raisonnable (qui ne pourra dépasser trente (30) jours), l'une ou l'autre partie pourra soumettre ledit litige à médiation. En cas d'incapacité à résoudre le litige par le biais de la médiation, les parties seront alors libres d'exercer les droits ou les voies de recours à leur disposition aux termes de la loi en vigueur. Nullité en cas d'interdiction Apple administre et exploite le Site www.apple.com à partir de ses bureaux de Cupertino en Californie, États-Unis ; les autres sites Apple peuvent être administrés et exploités depuis divers emplacements en dehors des États-Unis. Bien que le Site soit accessible partout dans le monde, l'ensemble des fonctionnalités, produits et services mentionnés, référencés, fournis ou offerts sur ou via le Site ne sont pas accessibles à toutes les personnes ou dans toutes les zones géographiques, ou appropriés ou disponibles pour une utilisation en dehors des États-Unis. Apple se réserve le droit de limiter, à sa seule discrétion, la fourniture et la quantité de toute fonctionnalité, produit ou service mis à disposition de toute personne ou zone géographique. Toute offre de fonctionnalité, de produit ou de service faite sur le Site est nulle et non avenue dans les pays où elle est interdite. Si vous choisissez d'accéder au Site depuis un emplacement situé en dehors des États-Unis, vous le faites à votre propre initiative et il est de votre seule responsabilité de vous conformer aux lois locales en vigueur. Divers Vous n'êtes pas autorisé à utiliser, exporter ou réexporter tout Contenu ou toute copie ou adaptation de ce Contenu, ou tout produit ou service offert sur le Site, en infraction aux lois ou règlements applicables, notamment les lois et les règlements sur le contrôle à l'exportation des États-Unis. Si des dispositions des présentes Conditions d'utilisation étaient considérées comme nulles ou inapplicables par une cour de justice ou un autre tribunal de la juridiction compétente, ces dispositions devront être limitées ou supprimées, dans la mesure minimale nécessaire, et remplacées par des dispositions valables qui expriment mieux l'intention de ces Conditions d'utilisation de façon à ce qu'elles restent pleinement applicables. Les présentes Conditions d'utilisation constituent la globalité de l'accord entre vous et Apple concernant l'utilisation du Site, et les autres accords écrits ou oraux existant précédemment entre vous et Apple concernant cette utilisation sont annulés et remplacés par les présentes. Apple n'acceptera aucune contre-proposition relative à ces Conditions d'utilisation, et toutes les propositions de cette nature sont catégoriquement rejetées aux termes des présentes. Tout manquement d'Apple à insister sur, ou à imposer un strict respect des présentes Conditions d'utilisation ne pourra être interprété comme une renonciation par Apple à toute disposition ou tout droit dont Apple dispose pour faire appliquer ces Conditions d'utilisation. De même, le cours des relations entre Apple et vous ou un tiers ne pourra être interprété comme modifiant les dispositions des présentes Conditions d'utilisation. Les présentes Conditions d'utilisation ne pourront être interprétées comme conférant des droits ou des voies de recours à un tiers. Les sites d'Apple donnent accès à des données internationales d'Apple et peuvent, par conséquent, contenir des références ou des références croisées à des produits, programmes et services Apple qui n'ont pas été annoncés dans votre pays. De telles références n'impliquent pas qu'Apple compte annoncer la sortie de ces produits, programmes et services dans votre pays. Commentaires et informations Tous les commentaires que vous nous faites parvenir sur le Site seront considérés comme non confidentiels. Apple sera libre d'utiliser ces informations sans aucune restriction. Les informations contenues sur ce site web sont susceptibles d'être modifiées sans préavis. Copyright © 1997-2007 Apple Inc. Tous droits réservés. Apple Inc. 1 Infinite Loop, Cupertino, CA 95014, États-Unis Mis à jour par l'équipe du service juridique d'Apple le 11/01/07"

let bigUnescapableText = "Toutes les mentions concernant les produits Apple sont fournies &agrave; titre d'information. Elles ne constituent pas un engagement de la part d'Apple. Les informations contenues sur le serveur Apple ne sont pas contractuelles. Elles peuvent &ecirc;tre modifi&eacute;es &agrave; tout moment et ne sauraient engager la responsabilit&eacute; d'Apple Computer France. Conform&eacute;ment au Code de la Propri&eacute;t&eacute; Intellectuelle, sont autoris&eacute;es les copies ou reproductions strictement r&eacute;serv&eacute;es &agrave; l'usage priv&eacute; du copiste et non destin&eacute;es &agrave; une utilisation collective et les repr&eacute;sentations priv&eacute;es et gratuites effectu&eacute;es exclusivement dans un cercle de famille. De m&ecirc;me, sont autoris&eacute;es, sous r&eacute;serve que soient indiqu&eacute;s clairement le nom de l'auteur et la source, les analyses et courtes citations justifi&eacute;es par le caract&egrave;re critique, pol&eacute;mique, p&eacute;dagogique, scientifique ou d'information de l'oeuvre &agrave; laquelle elles sont incorpor&eacute;es. Toute autre utilisation de tout ou partie du contenu du pr&eacute;sent site Web et ceci comprend notamment, les documents, &eacute;l&eacute;ments graphiques, logiciels, et autres pr&eacute;sentations sont interdites. Apple, le logo Apple, Macintosh sont des marques d&eacute;pos&eacute;es d'Apple Computer, Inc. Les autres marques cit&eacute;es sont des marques d&eacute;pos&eacute;es par leur propri&eacute;taire respectif. Droits de rectification Les informations dans ce formulaire sont destin&eacute;es &agrave; nos services internes et &agrave; nos partenaires. Vous disposez d'un droit d'acc&egrave;s et de rectification sur ces informations, que vous pouvez exercer aupr&egrave;s de : Apple Computer France 12, avenue d'Oc&eacute;anie 91956 Les Ulis. T&eacute;l&eacute;chargement de logiciels Droits d'auteurs - Logiciels Apple Apple Computer, B.V. Contrat de Licence Logiciel LISEZ SOIGNEUSEMENT CE CONTRAT DE LICENCE LOGICIEL &quot;LICENCE&quot; AVANT DE TELECHARGER OU D'UTILISER LE LOGICIEL. EN TELECHARGEANT OU EN UTILISANT LE LOGICIEL, VOUS ACCEPTEZ D'ETRE LIE PAR LES TERMES DE CETTE LICENCE. SI VOUS N'ETES PAS D'ACCORD AVEC LESDITS TERMES, VOUS N'ETES PAS AUTORISE A TELECHARGER OU UTILISER LE LOGICIEL. 1. Licence. Apple Computer, B.V. ou le cas &eacute;ch&eacute;ant, une filiale locale d'Apple Computer, Inc. (&quot;Apple&quot;) vous conc&egrave;de une licence sur, et en aucun cas ne vend, le Logiciel Apple et les fontes accompagnant la pr&eacute;sente Licence, qu'ils soient t&eacute;l&eacute;charg&eacute;s ou qu'ils soient sur disquette, sur m&eacute;moire morte (ROM) ou sur tout autre support (le &quot;Logiciel Apple&quot;). Vous &ecirc;tes propri&eacute;taire du support sur lequel, le cas &eacute;ch&eacute;ant, le Logiciel Apple est enregistr&eacute; mais Apple et/ou les Conc&eacute;dant(s) d'Apple restent propri&eacute;taire(s) du Logiciel Apple. Le Logiciel Apple que vous avez re&ccedil;u ainsi que les copies, que la pr&eacute;sente Licence vous autorise &agrave; r&eacute;aliser, sont r&eacute;gis par les termes de la pr&eacute;sente Licence. 2. Utilisations Permises et Limitations. La pr&eacute;sente Licence vous autorise &agrave; installer et utiliser le Logiciel Apple sur un seul ordinateur Apple ou sous licence Apple &agrave; la fois. La pr&eacute;sente Licence n'autorise pas le fonctionnement du Logiciel Apple sur plus d'un ordinateur &agrave; la fois. Vous pouvez r&eacute;aliser une seule copie du Logiciel Apple en langage machine aux fins exclusives de sauvegarde. La copie de sauvegarde doit imp&eacute;rativement reproduire les informations relatives au droit d'auteur figurant sur l'original. Sauf et dans les limites o&ugrave; la loi ou la pr&eacute;sente Licence l'autorise, vous ne pouvez pas d&eacute;compiler, d&eacute;sosser, d&eacute;sassembler, modifier, transmettre, louer, pr&ecirc;ter ou cr&eacute;er des produits d&eacute;riv&eacute;s du Logiciel Apple. Si le Logiciel Apple contient des &eacute;l&eacute;ments de cryptologie, le Logiciel Apple ne pourra pas &ecirc;tre import&eacute; en, ni utilis&eacute; en, ni r&eacute;-export&eacute; hors de France ou de ses D&eacute;partements ou Territoires d'Outre-Mer. La pr&eacute;sente Licence sera r&eacute;sili&eacute;e imm&eacute;diatement et de plein droit, sans notification pr&eacute;alable de la part d'Apple, si vous ne vous conformez pas &agrave; l'une quelconque de ses dispositions. 3. Exclusion de Garantie sur le Logiciel Apple. Vous reconnaissez et admettez express&eacute;ment que l'utilisation du Logiciel Apple est &agrave; vos risques et p&eacute;rils. Le Logiciel Apple est fourni &quot;TEL QUEL&quot; sans garantie d'aucune sorte, et Apple et le(s) conc&eacute;dant(s) d'Apple (aux fins des dispositions des paragraphes 4 et 5, l'expression &quot;Apple&quot; d&eacute;signe collectivement Apple et le(s) conc&eacute;dant(s) d'Apple) EXCLUENT EXPRESSEMENT TOUTE GARANTIE, EXPLICITE OU IMPLICITE, Y COMPRIS DE FA&Ccedil;ON NON LIMITATIVE LES GARANTIES IMPLICITES DE QUALITE MARCHANDE ET D'ADEQUATION A UN USAGE PARTICULIER. APPLE NE GARANTIT PAS QUE LES FONCTIONS CONTENUES DANS LE LOGICIEL APPLE CORRESPONDRONT A VOS BESOINS OU QUE LE FONCTIONNEMENT DU LOGICIEL APPLE SERA ININTERROMPU, EXEMPT D'ERREUR OU QUE TOUT DEFAUT DU LOGICIEL APPLE SERA CORRIGE. DE PLUS, APPLE NE GARANTIT PAS NI NE FAIT AUCUNE DECLARATION CONCERNANT L'UTILISATION OU LES RESULTATS DE L'UTILISATION DU LOGICIEL APPLE OU DE LA DOCUMENTATION Y AFFERENT EN CE QUI CONCERNE LEUR EXACTITUDE, FIABILITE OU AUTREMENT. SANS DIMINUER LA PORTEE GENERALE DE CE QUI PRECEDE, APPLE NE GARANTIT NI NE FAIT AUCUNE DECLARATION OU GARANTIE CONCERNANT L'AUTHENTICITE OU LA SECURITE DE TOUTE SIGNATURE ELECTRONIQUE RESULTANT DE L'UTILISATION DU LOGICIEL APPLE OU NE GARANTIT NI NE FAIT AUCUNE DECLARATION QUE TOUTE PERSONNE PHYSIQUE OU MORALE UTILISANT UNE TELLE SIGNATURE ELECTRONIQUE EST HABILITEE &Agrave; LE FAIRE. AUCUNE INFORMATION OU CONSEIL, COMMUNIQUEE VERBALEMENT OU PAR ECRIT PAR APPLE OU PAR UN DE SES REPRESENTANTS AUTORISES NE POURRA CREER UNE GARANTIE OU AUGMENTER DE QUELQUE MANIERE QUE CE SOIT L'ETENDUE DE LA PRESENTE GARANTIE. SI LE LOGICIEL APPLE S'AVERAIT DEFECTUEUX, VOUS ASSUMEREZ SEUL (ET NON PAS APPLE NI UN REPRESENTANT AUTORISE D'APPLE) LE COUT TOTAL DE TOUT ENTRETIEN, REPARATION OU MODIFICATION NECESSAIRE. CERTAINES LEGISLATIONS NE PERMETTENT PAS L'EXCLUSION DE GARANTIES IMPLICITES, IL EST DONC POSSIBLE QUE L'EXCLUSION MENTIONNEE CI-DESSUS NE S'APPLIQUE PAS A VOUS. La disposition suivante n'est applicable que pour la France : les pr&eacute;sentes ne pourraient vous priver de vos droits &agrave; la garantie l&eacute;gale (en cas de d&eacute;fauts ou de vices cach&eacute;s), dans la mesure o&ugrave; elle trouverait &agrave; s'appliquer. 4. Limitation de Responsabilit&eacute;. EN AUCUN CAS, Y COMPRIS LA NEGLIGENCE, APPLE NE SERA RESPONSABLE DE QUELQUES DOMMAGES INDIRECTS, SPECIAUX OU ACCESSOIRES RESULTANT OU RELATIF &Agrave; LA PRESENTE LICENCE. CERTAINES JURIDICTIONS NE PERMETTENT PAS LA LIMITATION OU L'EXCLUSION DE RESPONSABILITE POUR DOMMAGES INDIRECTS OU ACCESSOIRES, IL EST DONC POSSIBLE QUE L'EXCLUSION OU LA LIMITATION MENTIONNEE CI-DESSUS NE S'APPLIQUE PAS A VOUS. La seule responsabilit&eacute; d'Apple envers vous au titre de tout dommage n'exc&eacute;dera en aucun cas la somme pay&eacute;e pour la pr&eacute;sente Licence du Logiciel Apple. 5. Engagement Relatif aux Exportations. Vous vous engagez &agrave; ce que le Logiciel Apple ne soit pas export&eacute;, &agrave; l'ext&eacute;rieur des Etats-Unis, sauf autorisation par les lois des Etats-Unis. Vous vous engagez &agrave; ce que tout Logiciel Apple licitement obtenu en dehors des Etats-Unis ne soit pas re-export&eacute;, sauf autorisation par les lois des Etats-Unis et du pays dans lequel vous avez obtenu le Logiciel Apple. 6. Gouvernement des Etats-Unis. Si le Logiciel Apple est fourni au Gouvernement des Etats-Unis, le Logiciel Apple est class&eacute; &quot;restricted computer software&quot; tel que ce terme est d&eacute;fini dans la clause 52.227-19 du FAR. Les droits du Gouvernement des Etats-Unis sur le Logiciel Apple sont d&eacute;finis pas la clause 52.227-19 du FAR. 7. Loi Applicable et Divisibilit&eacute; du Contrat. Si une filiale d'Apple Computer, Inc. est pr&eacute;sente dans le pays o&ugrave; vous avez t&eacute;l&eacute;charg&eacute; la pr&eacute;sente Licence du Logiciel Apple, la pr&eacute;sente Licence sera r&eacute;gie par la loi du pays dans lequel la filiale est install&eacute;e. Dans le cas contraire, la pr&eacute;sente Licence sera r&eacute;gie et interpr&eacute;t&eacute;e par les lois des Etats-Unis et de l'Etat de Californie dans les conditions qui s'appliquent aux accords conclus et enti&egrave;rement ex&eacute;cut&eacute;s sur l'Etat de Californie par deux personnes au statut de r&eacute;sident de l'Etat de Californie. Si pour une quelconque raison, un tribunal ayant juridiction juge qu'une disposition de la pr&eacute;sente Licence est inapplicable, en totalit&eacute; ou en partie, ladite disposition sera rendue opposable dans la mesure o&ugrave; elle pourra refl&eacute;ter le plus fid&egrave;lement possible l'intention des parties et les autres dispositions de la pr&eacute;sente Licence continueront &agrave; produire leur effet. 8. Entente Compl&egrave;te. Cette Licence constitue l'int&eacute;gralit&eacute; de l'accord entre les parties concernant l'utilisation du Logiciel Apple et remplace toutes les propositions ou accords ant&eacute;rieurs ou actuels, &eacute;crits ou verbaux, &agrave; ce sujet. Aucune modification de cette Licence n'aura quelque effet &agrave; moins d'&ecirc;tre stipul&eacute;e par &eacute;crit et sign&eacute;e par un repr&eacute;sentant d&ucirc;ment autoris&eacute; d'Apple. Droits d'auteurs - Logiciels Tiers Toutes les demandes d'informations, r&eacute;clamations et tout paiement des redevances concernant les logiciels sont &agrave; adresser directement aupr&egrave;s de leur auteur respectif. Les noms et coordonn&eacute;es des auteurs figurent sur le fichier texte accompagnant les logiciels. Apple Computer France n'offre aucune garantie en ce qui concerne les logiciels tiers et ne garantit pas que les informations contenues ci-dessous soient compl&egrave;tes ou exactes. Toutes les mentions concernant les produits Apple sont fournies &agrave; titre d'information. Elles ne constituent pas un engagement de la part d'Apple. Les informations contenues sur le serveur Apple ne sont pas contractuelles. Elles peuvent &ecirc;tre modifi&eacute;es &agrave; tout moment et ne sauraient engager la responsabilit&eacute; d'Apple Computer France. Conform&eacute;ment au Code de la Propri&eacute;t&eacute; Intellectuelle, sont autoris&eacute;es les copies ou reproductions strictement r&eacute;serv&eacute;es &agrave; l'usage priv&eacute; du copiste et non destin&eacute;es &agrave; une utilisation collective et les repr&eacute;sentations priv&eacute;es et gratuites effectu&eacute;es exclusivement dans un cercle de famille. De m&ecirc;me, sont autoris&eacute;es, sous r&eacute;serve que soient indiqu&eacute;s clairement le nom de l'auteur et la source, les analyses et courtes citations justifi&eacute;es par le caract&egrave;re critique, pol&eacute;mique, p&eacute;dagogique, scientifique ou d'information de l'oeuvre &agrave; laquelle elles sont incorpor&eacute;es. Toute autre utilisation de tout ou partie du contenu du pr&eacute;sent site Web et ceci comprend notamment, les documents, &eacute;l&eacute;ments graphiques, logiciels, et autres pr&eacute;sentations sont interdites. Apple, le logo Apple, Macintosh sont des marques d&eacute;pos&eacute;es d'Apple Computer, Inc. Les autres marques cit&eacute;es sont des marques d&eacute;pos&eacute;es par leur propri&eacute;taire respectif. Droits de rectification Les informations dans ce formulaire sont destin&eacute;es &agrave; nos services internes et &agrave; nos partenaires. Vous disposez d'un droit d'acc&egrave;s et de rectification sur ces informations, que vous pouvez exercer aupr&egrave;s de : Apple Computer France 12, avenue d'Oc&eacute;anie 91956 Les Ulis. T&eacute;l&eacute;chargement de logiciels Droits d'auteurs - Logiciels Apple Apple Computer, B.V. Contrat de Licence Logiciel LISEZ SOIGNEUSEMENT CE CONTRAT DE LICENCE LOGICIEL &quot;LICENCE&quot; AVANT DE TELECHARGER OU D'UTILISER LE LOGICIEL. EN TELECHARGEANT OU EN UTILISANT LE LOGICIEL, VOUS ACCEPTEZ D'ETRE LIE PAR LES TERMES DE CETTE LICENCE. SI VOUS N'ETES PAS D'ACCORD AVEC LESDITS TERMES, VOUS N'ETES PAS AUTORISE A TELECHARGER OU UTILISER LE LOGICIEL. 1. Licence. Apple Computer, B.V. ou le cas &eacute;ch&eacute;ant, une filiale locale d'Apple Computer, Inc. (&quot;Apple&quot;) vous conc&egrave;de une licence sur, et en aucun cas ne vend, le Logiciel Apple et les fontes accompagnant la pr&eacute;sente Licence, qu'ils soient t&eacute;l&eacute;charg&eacute;s ou qu'ils soient sur disquette, sur m&eacute;moire morte (ROM) ou sur tout autre support (le &quot;Logiciel Apple&quot;). Vous &ecirc;tes propri&eacute;taire du support sur lequel, le cas &eacute;ch&eacute;ant, le Logiciel Apple est enregistr&eacute; mais Apple et/ou les Conc&eacute;dant(s) d'Apple restent propri&eacute;taire(s) du Logiciel Apple. Le Logiciel Apple que vous avez re&ccedil;u ainsi que les copies, que la pr&eacute;sente Licence vous autorise &agrave; r&eacute;aliser, sont r&eacute;gis par les termes de la pr&eacute;sente Licence. 2. Utilisations Permises et Limitations. La pr&eacute;sente Licence vous autorise &agrave; installer et utiliser le Logiciel Apple sur un seul ordinateur Apple ou sous licence Apple &agrave; la fois. La pr&eacute;sente Licence n'autorise pas le fonctionnement du Logiciel Apple sur plus d'un ordinateur &agrave; la fois. Vous pouvez r&eacute;aliser une seule copie du Logiciel Apple en langage machine aux fins exclusives de sauvegarde. La copie de sauvegarde doit imp&eacute;rativement reproduire les informations relatives au droit d'auteur figurant sur l'original. Sauf et dans les limites o&ugrave; la loi ou la pr&eacute;sente Licence l'autorise, vous ne pouvez pas d&eacute;compiler, d&eacute;sosser, d&eacute;sassembler, modifier, transmettre, louer, pr&ecirc;ter ou cr&eacute;er des produits d&eacute;riv&eacute;s du Logiciel Apple. Si le Logiciel Apple contient des &eacute;l&eacute;ments de cryptologie, le Logiciel Apple ne pourra pas &ecirc;tre import&eacute; en, ni utilis&eacute; en, ni r&eacute;-export&eacute; hors de France ou de ses D&eacute;partements ou Territoires d'Outre-Mer. La pr&eacute;sente Licence sera r&eacute;sili&eacute;e imm&eacute;diatement et de plein droit, sans notification pr&eacute;alable de la part d'Apple, si vous ne vous conformez pas &agrave; l'une quelconque de ses dispositions. 3. Exclusion de Garantie sur le Logiciel Apple. Vous reconnaissez et admettez express&eacute;ment que l'utilisation du Logiciel Apple est &agrave; vos risques et p&eacute;rils. Le Logiciel Apple est fourni &quot;TEL QUEL&quot; sans garantie d'aucune sorte, et Apple et le(s) conc&eacute;dant(s) d'Apple (aux fins des dispositions des paragraphes 4 et 5, l'expression &quot;Apple&quot; d&eacute;signe collectivement Apple et le(s) conc&eacute;dant(s) d'Apple) EXCLUENT EXPRESSEMENT TOUTE GARANTIE, EXPLICITE OU IMPLICITE, Y COMPRIS DE FA&Ccedil;ON NON LIMITATIVE LES GARANTIES IMPLICITES DE QUALITE MARCHANDE ET D'ADEQUATION A UN USAGE PARTICULIER. APPLE NE GARANTIT PAS QUE LES FONCTIONS CONTENUES DANS LE LOGICIEL APPLE CORRESPONDRONT A VOS BESOINS OU QUE LE FONCTIONNEMENT DU LOGICIEL APPLE SERA ININTERROMPU, EXEMPT D'ERREUR OU QUE TOUT DEFAUT DU LOGICIEL APPLE SERA CORRIGE. DE PLUS, APPLE NE GARANTIT PAS NI NE FAIT AUCUNE DECLARATION CONCERNANT L'UTILISATION OU LES RESULTATS DE L'UTILISATION DU LOGICIEL APPLE OU DE LA DOCUMENTATION Y AFFERENT EN CE QUI CONCERNE LEUR EXACTITUDE, FIABILITE OU AUTREMENT. SANS DIMINUER LA PORTEE GENERALE DE CE QUI PRECEDE, APPLE NE GARANTIT NI NE FAIT AUCUNE DECLARATION OU GARANTIE CONCERNANT L'AUTHENTICITE OU LA SECURITE DE TOUTE SIGNATURE ELECTRONIQUE RESULTANT DE L'UTILISATION DU LOGICIEL APPLE OU NE GARANTIT NI NE FAIT AUCUNE DECLARATION QUE TOUTE PERSONNE PHYSIQUE OU MORALE UTILISANT UNE TELLE SIGNATURE ELECTRONIQUE EST HABILITEE &Agrave; LE FAIRE. AUCUNE INFORMATION OU CONSEIL, COMMUNIQUEE VERBALEMENT OU PAR ECRIT PAR APPLE OU PAR UN DE SES REPRESENTANTS AUTORISES NE POURRA CREER UNE GARANTIE OU AUGMENTER DE QUELQUE MANIERE QUE CE SOIT L'ETENDUE DE LA PRESENTE GARANTIE. SI LE LOGICIEL APPLE S'AVERAIT DEFECTUEUX, VOUS ASSUMEREZ SEUL (ET NON PAS APPLE NI UN REPRESENTANT AUTORISE D'APPLE) LE COUT TOTAL DE TOUT ENTRETIEN, REPARATION OU MODIFICATION NECESSAIRE. CERTAINES LEGISLATIONS NE PERMETTENT PAS L'EXCLUSION DE GARANTIES IMPLICITES, IL EST DONC POSSIBLE QUE L'EXCLUSION MENTIONNEE CI-DESSUS NE S'APPLIQUE PAS A VOUS. La disposition suivante n'est applicable que pour la France : les pr&eacute;sentes ne pourraient vous priver de vos droits &agrave; la garantie l&eacute;gale (en cas de d&eacute;fauts ou de vices cach&eacute;s), dans la mesure o&ugrave; elle trouverait &agrave; s'appliquer. 4. Limitation de Responsabilit&eacute;. EN AUCUN CAS, Y COMPRIS LA NEGLIGENCE, APPLE NE SERA RESPONSABLE DE QUELQUES DOMMAGES INDIRECTS, SPECIAUX OU ACCESSOIRES RESULTANT OU RELATIF &Agrave; LA PRESENTE LICENCE. CERTAINES JURIDICTIONS NE PERMETTENT PAS LA LIMITATION OU L'EXCLUSION DE RESPONSABILITE POUR DOMMAGES INDIRECTS OU ACCESSOIRES, IL EST DONC POSSIBLE QUE L'EXCLUSION OU LA LIMITATION MENTIONNEE CI-DESSUS NE S'APPLIQUE PAS A VOUS. La seule responsabilit&eacute; d'Apple envers vous au titre de tout dommage n'exc&eacute;dera en aucun cas la somme pay&eacute;e pour la pr&eacute;sente Licence du Logiciel Apple. 5. Engagement Relatif aux Exportations. Vous vous engagez &agrave; ce que le Logiciel Apple ne soit pas export&eacute;, &agrave; l'ext&eacute;rieur des Etats-Unis, sauf autorisation par les lois des Etats-Unis. Vous vous engagez &agrave; ce que tout Logiciel Apple licitement obtenu en dehors des Etats-Unis ne soit pas re-export&eacute;, sauf autorisation par les lois des Etats-Unis et du pays dans lequel vous avez obtenu le Logiciel Apple. 6. Gouvernement des Etats-Unis. Si le Logiciel Apple est fourni au Gouvernement des Etats-Unis, le Logiciel Apple est class&eacute; &quot;restricted computer software&quot; tel que ce terme est d&eacute;fini dans la clause 52.227-19 du FAR. Les droits du Gouvernement des Etats-Unis sur le Logiciel Apple sont d&eacute;finis pas la clause 52.227-19 du FAR. 7. Loi Applicable et Divisibilit&eacute; du Contrat. Si une filiale d'Apple Computer, Inc. est pr&eacute;sente dans le pays o&ugrave; vous avez t&eacute;l&eacute;charg&eacute; la pr&eacute;sente Licence du Logiciel Apple, la pr&eacute;sente Licence sera r&eacute;gie par la loi du pays dans lequel la filiale est install&eacute;e. Dans le cas contraire, la pr&eacute;sente Licence sera r&eacute;gie et interpr&eacute;t&eacute;e par les lois des Etats-Unis et de l'Etat de Californie dans les conditions qui s'appliquent aux accords conclus et enti&egrave;rement ex&eacute;cut&eacute;s sur l'Etat de Californie par deux personnes au statut de r&eacute;sident de l'Etat de Californie. Si pour une quelconque raison, un tribunal ayant juridiction juge qu'une disposition de la pr&eacute;sente Licence est inapplicable, en totalit&eacute; ou en partie, ladite disposition sera rendue opposable dans la mesure o&ugrave; elle pourra refl&eacute;ter le plus fid&egrave;lement possible l'intention des parties et les autres dispositions de la pr&eacute;sente Licence continueront &agrave; produire leur effet. 8. Entente Compl&egrave;te. Cette Licence constitue l'int&eacute;gralit&eacute; de l'accord entre les parties concernant l'utilisation du Logiciel Apple et remplace toutes les propositions ou accords ant&eacute;rieurs ou actuels, &eacute;crits ou verbaux, &agrave; ce sujet. Aucune modification de cette Licence n'aura quelque effet &agrave; moins d'&ecirc;tre stipul&eacute;e par &eacute;crit et sign&eacute;e par un repr&eacute;sentant d&ucirc;ment autoris&eacute; d'Apple. Droits d'auteurs - Logiciels Tiers Toutes les demandes d'informations, r&eacute;clamations et tout paiement des redevances concernant les logiciels sont &agrave; adresser directement aupr&egrave;s de leur auteur respectif. Les noms et coordonn&eacute;es des auteurs figurent sur le fichier texte accompagnant les logiciels. Apple Computer France n'offre aucune garantie en ce qui concerne les logiciels tiers et ne garantit pas que les informations contenues ci-dessous soient compl&egrave;tes ou exactes."

let escapableTweet = "@LeMonde: #Dopage Martin Fourcade [@martinfkde] dénonce la « mascarade » des « pseudosanctions » contre le biathlon russe"
let escapedTweet = "@LeMonde: #Dopage Martin Fourcade [@martinfkde] d&eacute;nonce la &#x00ab; mascarade &#x00bb; des &#x00ab; pseudosanctions &#x00bb; contre le biathlon russe"

let egc = "I 💙 the 🇺🇸"
let escapedEGC = "I &#55357;&#56473; the &#127482;&#127480;"

// MARK: - Functions

func test() -> [Int: TimeInterval] {

    var result = [Int: TimeInterval]()

    /* --- */

    print("👉  Unicode-escaping 2 emojis")

    let emojiUnicodeEscape = measure {
        _ = egc.escapingForUnicodeHTML
    }

    result[1] = emojiUnicodeEscape

    /* --- */

    print("👉  ASCII-escaping 2 emojis")

    let emojiASCIIEscape = measure {
        _ = egc.escapingForASCIIHTML
    }

    result[2] = emojiASCIIEscape

    /* --- */

    print("👉  Unescaping 2 emojis")

    let emojiUnescape = measure {
        _ = escapedEGC.unescapingFromHTML
    }

    result[3] = emojiUnescape

    /* --- */

    print("👉  Unescaping a tweet")

    let tweetUnescape = measure {
        _ = escapedTweet.unescapingFromHTML
    }

    result[4] = tweetUnescape

    /* --- */

    print("👉  Unicode-escaping a tweet")

    let tweetUnicodeEscape = measure {
        _ = escapableTweet.escapingForUnicodeHTML
    }

    result[5] = tweetUnicodeEscape

    /* --- */

    print("👉  ASCII-escaping a tweet")

    let tweetASCIIEscape = measure {
        _ = escapableTweet.escapingForASCIIHTML
    }

    result[6] = tweetASCIIEscape

    /* --- */

    print("👉  Unicode-escaping 23,145 characters")

    let bigTextEscapeUnicode = measure {
        _ = bigEscapableText.escapingForUnicodeHTML
    }

    result[7] = bigTextEscapeUnicode

    /* --- */

    print("👉  ASCII-escaping 23,145 characters")

    let bigTextEscapeASCII = measure {
        _ = bigEscapableText.escapingForASCIIHTML
    }

    result[8] = bigTextEscapeASCII

    /* --- */

    print("👉  Unescaping 3,026 words with 366 escapes")

    let bigTextUnescape = measure {
        _ = bigUnescapableText.unescapingFromHTML
    }

    result[9] = bigTextUnescape

    /* --- */

    return result

}

func table(from results: [Int: TimeInterval]) -> String {

    let v = history.map { "| v\($0.value)) " }.joined() + "| v\(version) |"
    let s = history.map { _ in "|---" }.joined() + "|---|"

    let header = "| Task " + v
    let separator = "|:---" + s

    var lines = [header, separator]

    let sortedTasks = tasks.sorted { $0.key < $1.key }

    for (taskNumber, taskName) in sortedTasks {

        var _results: [String] = history.map {
            if let num = $0.value[taskNumber] {
                return String(format: "%.06f", num)
            }
            return "N/A"
        }

        let current: String

        if let num = results[taskNumber] {
            current = String(format: "%.06f", num)
        } else {
            current = "N/A"
        }

        _results.append(current)

        let elements = _results.map {
            "| \($0)s "
        }.joined()

        let line = "| \(taskName) " + elements + "|"
        lines.append(line)

    }

    return lines.joined(separator: "\n")

}

func versionAppendix(for results: [Int: TimeInterval]) -> String {

    let sortedResults = results.sorted { $0.key < $1.key }

    let minified = sortedResults.reduce(String()) {
        let num = String(format: "%.06f", $1.value)
        return $0 + "\($1.key):\(num),"
    }

    return "\"\(version)\":[\(minified)]"

}

// MARK: - Process

print("🔬  HTMLString Performance Benchmark")
print()

let results = test()
let outputTable = table(from: results)
let outputAppendix = versionAppendix(for: results)

print()
print("✅  Benchmark Complete")
print("💡  TODO: Compute complexity")

print()
print("📈  Results")
print()
print(outputTable)

print()
print("Add this line to the `history` dictionary in order")
print("to reuse the results from this test:")
print(outputAppendix)