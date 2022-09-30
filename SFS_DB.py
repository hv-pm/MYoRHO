# -*- coding: utf-8 -*-
"""
Created on Fri Jun 18 19:09:35 2021

,author: Hygor Vinícius
"""
import numpy
import pandas as pd
from mlxtend.plotting import plot_sequential_feature_selection as plot_sfs
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from sklearn.model_selection import train_test_split
from mlxtend.feature_selection import SequentialFeatureSelector as SFS
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline

X_train=numpy.array([
[ 0.153926655845924,268.304044126917,0.199644861811339,0.801118498637316,0.356913662585738,473.324466726216,0.114065955862310,0.0398695151112923,2833,275 ],
[ 0.110334286449200,186.056246474982,0.145983153355948,0.660389470023139,0.302037264382147,333.761216508832,0.0832029633027455,0.0213281867612696,2667,250 ],
[ 0.118413416538051,192.471748254915,0.159757846588232,0.687252001658116,0.311809568351323,337.951890799597,0.0911276755044027,0.0255225852903725,2557,255 ],
[ 0.135709329556828,238.013462693793,0.182920075129043,0.754290364214245,0.332647025020357,430.741412013373,0.100836626665022,0.0334608877123767,2858,278 ],
[ 0.110286439797880,185.462308798048,0.142736597758941,0.643082174059923,0.302395046622258,336.925073582523,0.0795572932828174,0.0203741075126384,2704,266 ],
[ 0.117448174719447,208.630728893352,0.156633945198121,0.701955210258778,0.310522223982811,366.555753299392,0.0901445515030477,0.0245360001488390,2752,286 ],
[ 0.0900136638815789,152.946930011604,0.118609095093727,0.569262286031349,0.272611746989216,279.672453680065,0.0665480245733909,0.0140716682773791,2604,256 ],
[ 0.0933802158219236,179.025512091480,0.123700044643696,0.610705584394567,0.276746071783662,328.791739908993,0.0687835859445438,0.0153023107479786,3010,304 ],
[ 0.0877688753212046,160.509763091193,0.114363580512860,0.565771024619269,0.269402424194890,292.621430320896,0.0637208495176697,0.0130799938534136,2799,290 ],
[ 0.0813775787261695,138.400563042204,0.108223744889664,0.520570827408939,0.258021158064679,256.909016038516,0.0590296531515772,0.0117191487972937,2597,265 ],
[ 0.0811326567826029,138.486276351091,0.105867548989989,0.514459942330462,0.259414037407414,256.784858716937,0.0581292168747867,0.0112174983646935,2666,270 ],
[ 0.0876310584214767,151.464437678706,0.112660471013648,0.552871861648076,0.269860161127858,270.166553113413,0.0643353630559692,0.0127110565452923,2648,274 ],
[ 0.105067919519441,221.406549529926,0.140623592791695,0.695018253056608,0.292632841399708,379.820529062778,0.0824296054658096,0.0197754564537499,3144,328 ],
[ 0.123537172076767,236.588548590163,0.162655172626759,0.733669048566106,0.319092039229663,433.615473989451,0.0914398787645204,0.0264587742334068,3103,299 ],
[ 0.114935636717000,188.686983596692,0.151759098203488,0.670814626833652,0.307785126576064,328.141242827035,0.0877330208801970,0.0230335984098399,2540,262 ],
[ 0.139380389768335,259.817478249446,0.183088728343522,0.768582083114907,0.339386138415739,480.862344700756,0.0999519019602698,0.0335244113172554,3099,293 ],
[ 0.132958948555111,235.075894437405,0.171686093801493,0.738029649460732,0.330752317058305,428.526691193122,0.0963896530780049,0.0294816385225360,2890,289 ],
[ 0.126031005001680,238.973966598123,0.166658233486903,0.743327397932306,0.321575363050431,412.751541380503,0.0967945308567022,0.0277830132174380,2923,301 ],
[ 0.0892188111493001,160.453257309030,0.114102165434738,0.566141683377453,0.273283789286207,279.254878897309,0.0658395207734319,0.0130196668959853,2711,286 ],
[ 0.102035346066203,190.511501324463,0.132590842018254,0.634593452377636,0.290956527164933,342.532656744245,0.0743860132693177,0.0176081276907145,2934,291 ],
[ 0.100949237136472,187.833159672965,0.133270577606503,0.631979351329542,0.288700606157907,338.886589067136,0.0739817482118668,0.0177636665640967,2895,293 ],
[ 0.104648037369996,179.627431026235,0.135816318500620,0.624040819858380,0.294739006609176,327.443708930716,0.0752448642686592,0.0184470771126183,2730,267 ],
[ 0.101244041012755,171.604503009325,0.132672996390889,0.617669423704388,0.289233682348962,302.820926669148,0.0758411539442318,0.0176050386111729,2607,271 ],
[ 0.102204305821781,176.007088117914,0.134599460440851,0.620102139556977,0.289852781698986,318.059799717383,0.0747660584797565,0.0181178763625348,2722,270 ],
[ 0.0989427376812616,173.795916253358,0.127725458015753,0.618439948633781,0.285738646598988,293.167331749579,0.0763320059555288,0.0163156230043317,2587,283 ],
[ 0.0974490177925040,193.451055675721,0.130111824555457,0.646224262862892,0.282533726391904,343.897583789746,0.0745626837583882,0.0169296127627372,3065,313 ],
[ 0.106395057758253,199.237978586472,0.137592977841576,0.652747424933195,0.297323122617203,351.529270833270,0.0782271118198853,0.0189378656408581,2915,292 ],
[ 0.121815351382584,217.750851391706,0.159896516122022,0.703088692602996,0.316967180337770,395.656261290631,0.0885691074673983,0.0255765511283151,2922,287 ],
[ 0.109848869441152,188.667026683325,0.141709171074583,0.647631246796365,0.302638737563206,338.664064487072,0.0800276944727674,0.0200852460613190,2717,270 ],
[ 0.119439951885162,215.782503216947,0.158543913583431,0.706460492094172,0.312739473278461,390.568642664479,0.0889757062556185,0.0251391475753578,2902,288 ],
[ 0.136439427745717,237.264116046627,0.176125818263832,0.742838689487934,0.336618693135261,432.512985953923,0.0982650550833724,0.0310222906242575,2848,271 ],
[ 0.136574959287968,254.798493241387,0.178993333119062,0.771623961230759,0.335918957656037,434.854670372891,0.104773746370596,0.0320433228784899,2914,303 ],
[ 0.127426743864531,240.855606388149,0.163029788354891,0.735704609519815,0.326490542179112,416.048318717694,0.0952524036345911,0.0265870651282895,2958,291 ],
[ 0.130448217800343,243.534199344509,0.167389249030075,0.740306936374139,0.330081283464610,433.870772403940,0.0953748134645112,0.0280243946320626,3014,297 ],
[ 0.0979281655024305,175.459167904772,0.126841300116709,0.610796324251866,0.284700712858383,302.989744064520,0.0733967032084963,0.0160887789019155,2692,293 ],
[ 0.111591693920050,190.679869576727,0.144962419832179,0.661778823451937,0.304407535343244,333.212798045269,0.0839864527623776,0.0210221351060651,2663,277 ],
[ 0.127123013726240,225.518238008501,0.169148998392226,0.727845919646634,0.321839905299201,400.818862278837,0.0951681345831855,0.0286141785720784,2806,289 ],
[ 0.126433344051465,235.913099895381,0.164399913862341,0.732021581990756,0.323734151036752,419.379402218709,0.0936864726082905,0.0270283548524647,2998,298 ],
[ 0.119389178528138,211.481316230499,0.154829332393675,0.698057789781362,0.314630279403094,379.896366076534,0.0884641770992071,0.0239780789460659,2822,281 ],
[ 0.114771939740427,202.456808645823,0.149418384075199,0.672092505561541,0.308887088240246,373.926979674313,0.0823597515670357,0.0223265811107203,2871,278 ],
[ 0.139663967932450,238.650567238100,0.183518612849973,0.749187330149047,0.339311282849702,446.924697383838,0.0992440751544566,0.0336804691475269,2851,263 ],
[ 0.113208024660504,209.907812076327,0.148005788359728,0.692730668685520,0.304871089747405,356.944901754569,0.0877935530109874,0.0219057525202734,2779,286 ],
[ 0.127828157883168,217.366925899194,0.169128626115260,0.717460286042588,0.323933430150762,399.335165227017,0.0933668417447664,0.0286843337549588,2783,271 ],
[ 0.134703824070858,234.744095985966,0.177388470394280,0.747807282577684,0.332987110233693,432.668682915598,0.0987537109698820,0.0314668731544212,2847,274 ],
[ 0.116573462767854,217.708258239046,0.151885375595284,0.704774660873178,0.310427189233314,384.226133282846,0.0882774821523400,0.0230707780443468,2889,290 ],
[ 0.123070181037887,216.694721527118,0.161644570584756,0.713013097037377,0.318381900480278,383.486684114057,0.0925444653272951,0.0261304281564528,2779,276 ],
[ 0.136036550259042,240.707812081133,0.179141036479889,0.755948503920543,0.334264830510979,424.842146458987,0.102040766287253,0.0320917231408816,2824,280 ],
[ 0.140668304863105,241.007132856150,0.186232145101075,0.771296890533042,0.339240568206182,430.304344576240,0.106807899594238,0.0347297160202056,2736,273 ],
[ 0.0932050639040081,165.608598553309,0.124038705579252,0.597364773999626,0.276668356286022,297.510563981594,0.0700055881692218,0.0153856928002659,2716,277 ],
[ 0.0597608090238343,106.367536829598,0.0803446480351056,0.410852885686167,0.220618667445097,185.856116064125,0.0461881646703952,0.00645887649905182,2435,259 ],
[ 0.0713777600245817,118.936514780492,0.0981998255679706,0.479734312326927,0.240766560807128,216.774257194655,0.0547779888115274,0.00965063147084378,2451,258 ],
[ 0.0853673769562714,148.881943306479,0.112579136526806,0.551111636730148,0.264123103414379,266.346216103568,0.0637048751284968,0.0126743524358675,2601,260 ],
[ 0.0755726088817806,123.684671485946,0.100809775027952,0.479415534208904,0.248479159166705,232.914780573647,0.0543393773871258,0.0101634555802988,2494,260 ],
[ 0.0855159656899669,142.822915323258,0.112248540634844,0.529962734382314,0.265003055754301,270.486999477366,0.0602605067327237,0.0126031051635785,2641,269 ],
[ 0.0962526064413347,170.327873268636,0.129150819959512,0.613018154474802,0.279170266357832,300.693142522729,0.0734178570888848,0.0166890192312454,2682,276 ],
[ 0.0921712211088509,170.247507810456,0.122560619367037,0.603354510292134,0.273862750794802,297.713044181588,0.0706134945115374,0.0150218662388515,2754,284 ],
[ 0.0923638819444009,155.478903483527,0.121414004051309,0.574717473948146,0.275097382003203,287.436400610975,0.0673428818030773,0.0147424304651849,2628,263 ],
[ 0.0965881198137907,171.399442096980,0.123078939228548,0.597683399978003,0.284245557418026,305.604811090835,0.0704150575594541,0.0151627439088271,2728,291 ],
[ 0.102117904310973,148.697131676226,0.138601404560578,0.590569661914265,0.287458908991005,276.024695352561,0.0749549714828890,0.0192125598008699,2306,238 ],
[ 0.0932786532600472,162.173440435774,0.123501714254666,0.588734987161583,0.277275003922247,299.704312924533,0.0684433958850924,0.0152530842741495,2777,265 ],
[ 0.200254127340887,343.860474945293,0.265791105903065,0.916779003166315,0.404309979677269,619.586269992704,0.148469684469061,0.0706727025723960,2855,279 ],
[ 0.180616113988992,297.340286312811,0.237691127774290,0.861417543945458,0.385313607311422,565.870285127509,0.129889951528831,0.0565201433401173,2856,256 ],
[ 0.217202661753763,336.313544269272,0.282407628921891,0.918717021537937,0.423159988355577,622.285625924532,0.154983208070995,0.0797544537875349,2689,252 ],
[ 0.205374427344258,343.624543386961,0.270937524797122,0.919215563604198,0.410825854971409,637.071473621885,0.149116109626141,0.0734072911427709,2864,264 ],
[ 0.204417603319167,343.805573412819,0.268345762781023,0.909786290451793,0.408937531097692,639.622680785675,0.145284782255337,0.0720117647512941,2897,266 ],
[ 0.233070955553748,381.882079345951,0.309584416276728,0.970051307407831,0.435219028615629,718.324685016652,0.168178667394062,0.0958428571884410,2860,262 ],
[ 0.163839061387289,287.678295062498,0.217587317810166,0.834343505904314,0.366315843904820,523.629640193774,0.120792025752420,0.0473449419183772,2899,274 ],
[ 0.135149077374999,216.095394762917,0.179143672150587,0.720438900716368,0.332253525814985,412.474984148498,0.0951093008732536,0.0320932061295228,2697,252 ],
[ 0.125951680156611,206.754859054805,0.164183380961973,0.694202709634324,0.322548491454723,393.850903849724,0.0884662424813404,0.0269564210390184,2746,258 ],
[ 0.116697131739953,196.699984753628,0.155588054086434,0.671899868991334,0.309161352371933,370.396696142612,0.0834120070992773,0.0242085057976926,2772,262 ],
[ 0.127446043793730,217.488497238001,0.168665468022926,0.716911487022978,0.322565867909506,413.180073979271,0.0915198049120477,0.0284535171271385,2836,268 ],
[ 0.124148609007447,202.564708463791,0.165478796869524,0.693419908051172,0.318545847797819,387.343660103237,0.0884036037575158,0.0273873283009070,2735,266 ],
[ 0.198809221899173,371.210349947073,0.259444800452984,0.922962787764375,0.403084593957059,685.295387886449,0.142681072451945,0.0673127538135217,3145,286 ],
[ 0.170069593195493,281.963146934704,0.229681511431142,0.836968697122679,0.372001919319298,550.345203580616,0.120764339911731,0.0527897353328075,2892,253 ],
[ 0.155523569346154,261.811062259076,0.208427193295903,0.800484715134406,0.354483144701529,486.322201345423,0.112958940090311,0.0434421564689356,2784,274 ],
[ 0.194374666238551,334.488157449514,0.259862220623010,0.905727391455638,0.398421319428463,617.917063972354,0.142796778007062,0.0675308569527306,2926,271 ],
[ 0.222120987222213,362.016807489385,0.294572863455013,0.936229322334032,0.424381878485785,702.568682583860,0.153573624110555,0.0867981069116219,2921,255 ],
[ 0.207939680224159,371.798360937345,0.281839979895223,0.939937715030688,0.408658142168363,702.836119157655,0.149833108397549,0.0794337753077773,3097,283 ],
[ 0.225079613212539,360.972202296310,0.298008505539512,0.936586989763166,0.427373605078536,702.473472836334,0.154673773480809,0.0888102145081138,2869,253 ],
[ 0.141174193360098,201.522444274423,0.185375244898257,0.714140759862114,0.340010669255900,388.370205933631,0.0987414614725601,0.0343836230030677,2429,221 ],
[ 0.150632379351207,238.682045140876,0.198451243075640,0.765652722502023,0.351829210174082,453.102197088430,0.106295344580269,0.0393882626223859,2711,246 ],
[ 0.151514785891373,257.740131121413,0.196085287470917,0.777914816295080,0.353884789627776,482.574593064022,0.106263316882548,0.0384502575490174,2878,268 ],
[ 0.181874124292826,270.977850753809,0.240795763249015,0.821332332058157,0.384509238459431,554.534204968829,0.120058980206751,0.0579863097211946,2768,243 ],
[ 0.132593016576016,228.425823914553,0.170925904044702,0.720287125555260,0.331664250552266,434.109536269875,0.0918074386775745,0.0292167041274288,2931,273 ],
[ 0.174698339453815,306.975024184110,0.233475674243178,0.861649603432200,0.377304352283018,562.703351380740,0.128150021663977,0.0545189256110551,2929,287 ],
[ 0.140545197052479,233.070910786753,0.183069106843559,0.744098821286120,0.341387743893263,437.798288818471,0.0994160764848426,0.0335143221931012,2810,264 ],
[ 0.143553196553298,230.998435187905,0.190089993025543,0.746073457184152,0.343523365047249,440.995419811734,0.100577823111157,0.0361354720339948,2743,259 ],
[ 0.163125622486166,240.722258475101,0.219663807205547,0.791335236987369,0.362997823843269,453.489230511542,0.117322126040768,0.0482688352972223,2517,235 ],
[ 0.152790968009203,237.069863269548,0.209546727997399,0.789072590452988,0.349089691507612,439.885196898495,0.114709111519622,0.0439105099902448,2573,260 ],
[ 0.160263933679424,278.206443903177,0.216258008369711,0.823979615755386,0.360654780593955,510.440628768967,0.118170053320237,0.0467679009971566,2887,275 ],
[ 0.206479943575952,384.930288260561,0.270399212899489,0.942157333285120,0.412874494275551,694.805010133078,0.150932334741274,0.0731239709443710,3152,293 ],
[ 0.177286154100811,268.414516642188,0.235791751417935,0.823427153721125,0.380971640689128,507.392973036523,0.124507387530088,0.0556033885850651,2647,253 ],
[ 0.193733561442976,318.063438136733,0.255080972765935,0.878377689195153,0.399095199197125,608.517116492387,0.134890462239301,0.0650803688152552,2887,261 ],
[ 0.197345566975723,334.160831936855,0.255414924805378,0.886005092193638,0.404498994239439,641.373092671099,0.134953699536445,0.0652544053832302,3024,267 ],
[ 0.174851342074286,276.296960398361,0.230596692070461,0.832771021929776,0.377391276884875,508.817405436170,0.126175145547740,0.0531761438889247,2689,254 ],
[ 0.185632930100459,325.432485226291,0.244373918222818,0.881324675789402,0.390175141561397,595.881705622472,0.134340665279845,0.0597282168686697,2961,274 ],
[ 0.245871558527827,404.184941741502,0.330315124669099,0.997347915808248,0.445690015180721,763.677060787430,0.178388208847718,0.109135882940064,2891,246 ],
[ 0.196965430530267,330.737429732722,0.261022795173123,0.896492698821515,0.401245475038034,627.925792530491,0.139557359680562,0.0681348078232992,2964,269 ],
[ 0.211371892757863,355.895449608376,0.279653623122910,0.924775501638885,0.415349728911589,669.837528149669,0.149392844022310,0.0782346433058422,2943,270 ],
[ 0.190122521899809,297.661043233722,0.251518405386165,0.863451656132200,0.394249330703949,550.024455856148,0.135791847741267,0.0633022199914167,2663,252 ],
[ 0.198775240182087,337.215243360479,0.261779833321031,0.908072226162187,0.402924080816245,617.594671245746,0.145224289177203,0.0685556981923456,2866,263 ],
[ 0.205164045791910,347.242480761141,0.271389444038868,0.913875509515443,0.409313069104937,649.549368977189,0.145797779340495,0.0737996320560989,2930,273 ],
[ 0.236425931981606,405.216897355880,0.311177443369033,0.983755529017352,0.440020543279012,750.652334041601,0.171008973631182,0.0968598016084574,2961,271 ],
[ 0.156504917485255,255.740305428048,0.209155323373497,0.792213645682689,0.356661052024820,479.061552422365,0.112031470585321,0.0437668571185075,2789,255 ],
[ 0.208545746427176,333.047977153869,0.280240939803164,0.916590122737355,0.409845117898525,617.712500917293,0.151682509088540,0.0785559162103510,2741,262 ],
[ 0.206756064868390,321.347843138910,0.270414513142342,0.898358969799833,0.413583494041790,608.276342842805,0.145923143315747,0.0731366512778968,2718,248 ],
[ 0.185279153575694,298.714329997766,0.239302353329433,0.850711343063293,0.392040308514203,576.403446773983,0.127070813425313,0.0573275581325587,2847,258 ],
[ 0.203763307073567,340.400239881926,0.265710056713321,0.902358762021945,0.409350801251145,649.597422950532,0.141493103863888,0.0706019670351399,2932,266 ],
[ 0.152709346865440,253.286046551716,0.204974441122779,0.786148855961587,0.350113898800249,478.285674382556,0.109238666178063,0.0420163063705970,2765,274 ],
[ 0.161533426725436,249.700637515198,0.212274901891219,0.778086113746949,0.363129942129924,494.615352633283,0.108423679260692,0.0450633476484788,2752,245 ],
[ 0.125845518513762,209.888150645843,0.167623768453084,0.697687212816387,0.318870949165561,399.307830244168,0.0885135847962668,0.0281074275581482,2752,266 ],
[ 0.146479080571146,248.583256713010,0.196505035765688,0.775178927855607,0.344757069561339,475.617574614511,0.104594951996397,0.0386151279852692,2860,266 ],
[ 0.125066635694793,188.469547978033,0.171542568399933,0.686972002156646,0.316317955853591,359.816710893919,0.0907064301863271,0.0294376652797410,2502,235 ],
[ 0.115930985605777,192.503020882384,0.151662284228683,0.660787573901210,0.308749254141401,357.531159608218,0.0824781382362376,0.0230091207157788,2701,259 ],
[ 0.175665384789741,304.635747289821,0.243819540472407,0.874146473794833,0.371075706770457,581.452423654041,0.130124789402947,0.0594662489863735,2934,274 ],
[ 0.134887240273861,226.528077377988,0.179392990174832,0.724239607769238,0.331682049510284,423.141272739102,0.0946426452845292,0.0321827337252044,2801,256 ],
[ 0.156011339424296,247.247292341832,0.207784676299415,0.787471562446681,0.355392877298328,478.954812032589,0.110656559628048,0.0432031889776811,2731,254 ],
[ 0.122960005318100,205.170459962220,0.161558964643488,0.687413125443034,0.318122695311803,389.537296847742,0.0865180502413174,0.0261213496443011,2767,257 ],
[ 0.112391129698671,184.949188706848,0.147653310980630,0.658229724882514,0.303440097843658,332.452961648669,0.0837261929182688,0.0218153131098630,2569,257 ],
[ 0.119037003003429,198.842009472651,0.156762071896340,0.677284376997891,0.312375274346817,365.919747232541,0.0857993507109535,0.0245749755171801,2679,265 ],
[ 0.0358403508328101,80.9368859485876,0.0527600087650463,0.306682580961761,0.170142552590404,114.904164769989,0.0357942968979131,0.00284135292283459,2368,356 ],
[ 0.0360787783079236,76.9193711784763,0.0515529319855134,0.262264583941974,0.170790858032158,115.199539137200,0.0323818043150871,0.00266771862516781,2322,340 ],
[ 0.0357928930714038,83.1188370180041,0.0493393820703777,0.281736145037344,0.171114495602585,117.508067953418,0.0333972239536750,0.00243509634356157,2461,361 ],
[ 0.0316001707284413,69.0468042355833,0.0425709282604021,0.214444791557268,0.161912567384142,95.4325155998932,0.0298252198003453,0.00181242417670128,2199,336 ],
[ 0.0324672643012039,72.5257220374418,0.0449338759445362,0.234116876660795,0.163056866166066,102.109546227286,0.0305802817247470,0.00201948014637825,2261,344 ],
[ 0.0330613431631312,73.3946833593830,0.0437661235960270,0.225494758363050,0.166018331627980,104.705273797637,0.0298670409804262,0.00192038183594941,2281,344 ],
[ 0.0300847033056606,51.9827932995688,0.0434201803649626,0.119514142004232,0.155514268251792,91.6981756756532,0.0238538267403535,0.00189433753439290,1827,241 ],
[ 0.0301819756710566,47.2931013703962,0.0422971485455421,0.104012425003562,0.156453379039945,81.7327901172211,0.0244234445820065,0.00178936149753591,1635,216 ],
[ 0.0215906854628264,40.7155029501055,0.0296481914813742,-0.00586778385685397,0.132738967954172,64.5561495338507,0.0180414709427770,0.000884218445243702,1577,252 ],
[ 0.0250655987656146,47.2949556382719,0.0377824271836211,0.0766470666750823,0.140703361849253,77.9038809635302,0.0214063235394570,0.00143434326931973,1741,252 ],
[ 0.0224145168035940,43.4555126597902,0.0327386706940394,0.0333232854876087,0.133397881998623,66.7728455579062,0.0197890090713924,0.00107278978321573,1651,273 ],
[ 0.0287839494902814,53.8767486016897,0.0446973163655368,0.162526242494933,0.150101592828571,90.4103853489740,0.0259493152386283,0.00201871774485665,1799,249 ],
[ 0.0262397214564523,46.5547434362057,0.0367484061503782,0.0839644239266998,0.146436615986105,71.3195629186374,0.0232736538700787,0.00135220157805400,1652,245 ],
[ 0.0332653564817408,55.0579565781377,0.0480598434716079,0.187230586227906,0.163537288448465,89.3174821534736,0.0297108126471195,0.00231202862659558,1778,240 ],
[ 0.0438557990416134,81.0740539547123,0.0625625289277099,0.304433777446438,0.187189771978829,142.662914282369,0.0353507266148781,0.00391742843724391,2271,284 ],
[ 0.0250817600972835,45.3278998710814,0.0351721332776768,0.0739446036051257,0.142629160287172,68.4481233054868,0.0226853563091683,0.00124040699126201,1637,260 ],
[ 0.0261597281429504,52.1965983443656,0.0394403749357275,0.129399860217921,0.144978877063813,77.1450382935606,0.0248040982361273,0.00155698169638363,1832,305 ],
[ 0.0340402116023190,61.2636080181197,0.0484577273382203,0.194858137441182,0.164411479636972,101.916393537343,0.0286280156263358,0.00235239300193310,1978,274 ],
[ 0.0259391448500913,56.3275432036760,0.0332339041046952,0.114772586792477,0.147547061996085,78.6474871854771,0.0236619388412204,0.00110484434190101,1997,314 ],
[ 0.0273335160624306,55.5469706565277,0.0363199316207094,0.137229442360737,0.150294550823263,78.9391943882998,0.0255314946144929,0.00137812020117114,1874,307 ],
[ 0.0259678459879781,54.4184058084323,0.0328938354639556,0.105757482676534,0.147960956645705,74.4757822935211,0.0238242702530952,0.00108348843800337,1916,312 ],
[ 0.0270770948443751,59.8388250958317,0.0376849159666979,0.149237537380652,0.148833794923901,85.2657716649367,0.0251290712217848,0.00142273123090889,2045,338 ],
[ 0.0250004341020640,59.7347629743753,0.0331372348639480,0.127074612275963,0.143895714358281,82.4264312345051,0.0233421321732762,0.00109954966760047,2146,358 ],
[ 0.0280145681020985,60.3958095514256,0.0404635344647830,0.165945079045191,0.150300605670667,87.2933942061388,0.0262594328994643,0.00163835746228400,2042,327 ],
[ 0.0260907561128396,57.9469056651494,0.0340117334166622,0.124308514905396,0.147530909903454,79.6550784124996,0.0240869488034791,0.00115722360556257,2051,334 ],
[ 0.0282443872582062,54.9154470995921,0.0375647239485966,0.129877119941119,0.152822668531374,77.3896210874851,0.0257722141279687,0.00141123433528221,1857,291 ],
[ 0.0277477057639087,58.4253360545857,0.0375418683035256,0.149118787451730,0.151491917580413,81.2175347709609,0.0260612298544642,0.00141192105379776,2015,317 ],
[ 0.0361810612327981,71.5159137839148,0.0495242439008900,0.242820217366209,0.171605521053315,109.194442800585,0.0318495592004227,0.00247388942619430,2115,303 ],
[ 0.0356916861307353,73.2150063570269,0.0487502914698486,0.234463137848180,0.171035185009328,113.749403698654,0.0303742836204376,0.00237723737764013,2263,323 ],
[ 0.0282311596182124,59.1910549974868,0.0384343280487319,0.152163268745435,0.152432580431602,84.2417803007458,0.0259957409495527,0.00148275580599084,1984,324 ],
[ 0.0450152222639993,87.9888282902612,0.0613487075022279,0.324083344660624,0.191648536237556,142.563208910086,0.0374823634245775,0.00376504811047804,2369,298 ],
[ 0.0429780413349889,82.5863212531201,0.0590253039146421,0.307398083383279,0.187103399418500,130.911113906376,0.0367854147059579,0.00348398703402548,2280,310 ],
[ 0.0367955427011080,72.6022864258756,0.0520390483951304,0.259790464713717,0.172872146956814,107.774144571546,0.0336148942105825,0.00270962909618292,2118,303 ],
[ 0.0461097825119220,85.2243782518303,0.0636363830642466,0.331317320982703,0.193240996074271,134.410016022252,0.0397326078270445,0.00406439951962952,2230,294 ],
[ 0.0407056905542851,80.9705394680977,0.0576778248614713,0.292628174736227,0.181420633346118,126.879637457707,0.0351459405034704,0.00332704680097724,2305,309 ],
[ 0.0419472121937811,85.2431931197346,0.0550870049423731,0.299403852579639,0.186357768189113,133.811606898162,0.0352894165488850,0.00305057925288129,2364,304 ],
[ 0.0334523074285328,69.6290178614739,0.0472789003617991,0.226291100278876,0.165370448361764,101.661562275311,0.0305519646154599,0.00225207555797715,2174,324 ],
[ 0.0295406459070283,62.0079391945369,0.0403351916972356,0.184033080173571,0.155662354409471,87.7652589897814,0.0280261578097044,0.00163024733236374,2000,309 ],
[ 0.0281654034000364,54.4477280544142,0.0400286699034773,0.130210451038478,0.151123147839765,79.6235954119030,0.0253921740442843,0.00161185785287010,1883,299 ],
[ 0.0303720903158065,63.7699017961081,0.0443485052171342,0.199437283452779,0.156146159186356,91.1466430377351,0.0289032116955415,0.00196793418683649,2057,327 ],
[ 0.0315992785101127,66.7783809031764,0.0456547831119538,0.217184982060792,0.159226429101699,97.5153734822077,0.0296885989809230,0.00208717525379506,2116,323 ],
[ 0.0319110860214376,67.4646476678737,0.0465764217240134,0.221093752741873,0.159764990689130,98.9881888384992,0.0298637161387542,0.00217324369811822,2112,318 ],
[ 0.0417654688550825,73.1388734555184,0.0591098089279170,0.277181486356312,0.182663833916462,126.424074224335,0.0344182731020301,0.00353759503461567,2134,262 ],
[ 0.0284238132723693,58.8340443523128,0.0402749019006908,0.160206860379224,0.152398187842386,86.4083923480024,0.0262312194238660,0.00162271734235556,2002,315 ],
[ 0.0278638946006074,56.5390212446384,0.0371492910080926,0.133398458142492,0.151413184264363,83.6752754856239,0.0248169208225923,0.00138476013550275,1958,295 ],
[ 0.0337954554035802,70.4670223903707,0.0481005563608734,0.253184912473277,0.165754846360773,105.137661760538,0.0321263844881897,0.00231595370807770,2142,314 ],
[ 0.0361188150697864,71.7606029422614,0.0600290933012467,0.290929352193374,0.167402262152081,113.954861545176,0.0347990082432705,0.00360367030208374,2191,310 ],
[ 0.0358871108589570,73.4194879408450,0.0584259150490699,0.294870037007951,0.167241273850592,114.013351198907,0.0349924986881917,0.00345706402937836,2208,315 ],
[ 0.0206322832967544,39.7749473767816,0.0364180076189368,0.0841788402821322,0.126529620972442,61.1747199748770,0.0223004064493012,0.00135695085430742,1473,252 ],
[ 0.0163819649512272,35.6590293209548,0.0235505695323356,-0.0546462255870289,0.115603512921662,52.0291206850975,0.0156510953926588,0.000559596085047944,1394,270 ],
[ 0.0180558757595076,38.3042382997725,0.0312052033977704,0.0267693520891052,0.117073386692324,57.6704671758673,0.0188226244329627,0.000974449555962552,1407,267 ],
[ 0.0188013873192129,34.3430968031436,0.0301204960291775,-0.0164343485628503,0.121141115678380,51.0269651843440,0.0184890767241760,0.000908896498587249,1331,242 ],
[ 0.0173351752294611,37.3698774401827,0.0250263069241594,-0.0401248643450322,0.118093592880610,53.9817356645416,0.0163380320029847,0.000627334731589065,1490,267 ],
[ 0.0174853998306557,36.7747508227650,0.0268209385768373,-0.0342822081520743,0.117898654366333,54.1522832755408,0.0166103844937764,0.000719515152813752,1468,271 ],
[ 0.0204054884864180,41.6550139618889,0.0301446203899544,0.0344717047112841,0.127909440100504,63.7875570085427,0.0193688374443719,0.000916679177268076,1554,255 ],
[ 0.0217193792686534,39.5054343694457,0.0292681415602578,-0.0150042900596226,0.133589514582993,62.6386898107965,0.0179948320566967,0.000858197014511906,1536,242 ],
[ 0.0222574632798750,46.4542257635811,0.0346956186532305,0.0690312900310562,0.132743817597002,69.4432854332105,0.0209939007844967,0.00120452279956944,1765,301 ],
[ 0.0226089033796848,46.0944670916651,0.0348798856580296,0.0716213646070665,0.133489599178183,71.6476148102213,0.0209483974413973,0.00122356944346204,1717,269 ],
[ 0.0208464306642272,41.7837813336449,0.0336655544971253,0.0439719911723201,0.127935169635366,65.0617101030529,0.0198133032922699,0.00113595500458555,1544,271 ],
[ 0.0197096630578177,38.5085869470280,0.0321566413788567,0.00790983637600821,0.122946135194223,58.6756669231234,0.0186652827190435,0.00103965607141917,1454,246 ]
])

y_train=numpy.array([ 
[1], [1], [1], [1], [1], [1], 
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1], 
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[1], [1], [1], [1], [1], [1],
[2], [2], [2], [2], [2], [2], 
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2], 
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[2], [2], [2], [2], [2], [2],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0],
[0], [0], [0], [0], [0], [0]
])

lda = LDA(n_components=None)

sfs1 = SFS(estimator=lda, 
           k_features=(1, 10),
           forward=True, 
           floating=False, 
           verbose=2,
           scoring='accuracy',
           cv=10) #k-fold cross validation

feature_names = ('MAV', 'WL', 'RMS', 'MFL', 'MSR', 'IAV', 'DASDV', 'VAR', 'WAMP', 'ZC')
sfs1 = sfs1.fit(X_train, y_train, custom_feature_names=feature_names)

print('best combination (ACC: %.3f): %s\n' % (sfs1.k_score_, sfs1.k_feature_idx_))
print('all subsets:\n')
sfs1.subsets_
plot_sfs(sfs1.get_metric_dict(), kind='std_err');
moreinfo = pd.DataFrame.from_dict(sfs1.get_metric_dict()).T